Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936383AAF4F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jun 2021 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFQJKV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 17 Jun 2021 05:10:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46393 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhFQJKU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jun 2021 05:10:20 -0400
Received: (Authenticated sender: paul@opendingux.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5B3051BF208;
        Thu, 17 Jun 2021 09:08:09 +0000 (UTC)
Date:   Thu, 17 Jun 2021 10:08:02 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] iio: core: Support reading extended name as label
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-Id: <ED9UUQ.EDOA8S56T8BP@crapouillou.net>
In-Reply-To: <CA+U=DsrP6+Zjnca8Sqd0jAi9a4aDqAV4suJZc95ayqm7K0+mCw@mail.gmail.com>
References: <20210616155706.17444-1-paul@crapouillou.net>
        <20210616155706.17444-3-paul@crapouillou.net>
        <CA+U=DsrP6+Zjnca8Sqd0jAi9a4aDqAV4suJZc95ayqm7K0+mCw@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

Le jeu., juin 17 2021 at 10:22:35 +0300, Alexandru Ardelean 
<ardeleanalex@gmail.com> a écrit :
> On Wed, Jun 16, 2021 at 7:00 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  The point of this new change is to make the IIO tree actually 
>> parsable.
>> 
>>  Before, given this attribute as a filename:
>>  in_voltage0_aux_sample_rate
>> 
>>  Userspace had no way to know if the attribute name was
>>  "aux_sample_rate" with no extended name, or "sample_rate" with 
>> "aux" as
>>  the extended name, or just "rate" with "aux_sample" as the extended
>>  name.
>> 
>>  This was somewhat possible to deduce when there was more than one
>>  attribute present for a given channel, e.g:
>>  in_voltage0_aux_sample_rate
>>  in_voltage0_aux_frequency
>> 
>>  There, it was possible to deduce that "aux" was the extended name. 
>> But
>>  even with more than one attribute, this wasn't very robust, as two
>>  attributes starting with the same prefix (e.g. "sample_rate" and
>>  "sample_size") would result in the first part of the prefix being
>>  interpreted as being part of the extended name.
>> 
>>  To address the issue, knowing that channels will never have both a 
>> label
>>  and an extended name, set the channel's label to the extended name.
>>  In this case, the label's attribute will also have the extended 
>> name in
>>  its filename, but we can live with that - userspace can open
>>  in_voltage0_<prefix>_label and verify that it returns <prefix> to 
>> obtain
>>  the extended name.
>> 
> 
> The best way would have been for all drivers [using extend_name] to
> implement their own read_label hook.

Let's agree to disagree :)

> But this can work fine as well [as the other method would add some 
> duplication].
> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/iio/industrialio-core.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>>  diff --git a/drivers/iio/industrialio-core.c 
>> b/drivers/iio/industrialio-core.c
>>  index 81f40dab778a..9b37e96538c2 100644
>>  --- a/drivers/iio/industrialio-core.c
>>  +++ b/drivers/iio/industrialio-core.c
>>  @@ -717,8 +717,12 @@ static ssize_t iio_read_channel_label(struct 
>> device *dev,
>>          struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>          struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> 
>>  -       if (!indio_dev->info->read_label)
>>  -               return -EINVAL;
>>  +       if (!indio_dev->info->read_label) {
>>  +               if (this_attr->c->extend_name)
>>  +                       return sprintf(buf, "%s\n", 
>> this_attr->c->extend_name);
>>  +               else
> 
> nitpick: else statement has no effect
> 
> well, this block could be reworked a bit as:
> 
> ----------------------------------------------------
> if (indio_dev->info->read_label)
>    return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
> 
> if (this_attr->c->extend_name)
>     return sprintf(buf, "%s\n", this_attr->c->extend_name);
> 
> return -EINVAL;
> ----------------------------------------------------

I generally prefer to make the diff as small as possible so that the 
changes are more obvious. But this does look better.

-Paul

> 
>>  +                       return -EINVAL;
>>  +       }
>> 
>>          return indio_dev->info->read_label(indio_dev, this_attr->c, 
>> buf);
>>   }
>>  @@ -1160,7 +1164,7 @@ static int 
>> iio_device_add_channel_label(struct iio_dev *indio_dev,
>>          struct iio_dev_opaque *iio_dev_opaque = 
>> to_iio_dev_opaque(indio_dev);
>>          int ret;
>> 
>>  -       if (!indio_dev->info->read_label)
>>  +       if (!indio_dev->info->read_label && !chan->extend_name)
>>                  return 0;
>> 
>>          ret = __iio_add_chan_devattr("label",
>>  --
>>  2.30.2
>> 


