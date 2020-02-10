Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A10157338
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJLDp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 06:03:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJLDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 06:03:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6B1C528FC9F
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Gwendal Grignou <gwendal@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
 <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux>
 <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
 <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
 <CAPUE2usO-Ny61+wEdTcwR3b+RgGjeQ4Jb24UeF8siscqFQ5ogQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2ebc4e17-df7a-d5c2-f657-16d06e402bd4@collabora.com>
Date:   Mon, 10 Feb 2020 12:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPUE2usO-Ny61+wEdTcwR3b+RgGjeQ4Jb24UeF8siscqFQ5ogQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal, Prashant et all

On 7/2/20 19:47, Gwendal Grignou wrote:
> On Thu, Feb 6, 2020 at 10:50 AM Prashant Malani <pmalani@chromium.org> wrote:
>>
>> Hi Enric,
>>
>> Thanks for taking a look at the patch. Please see my response inline:
>>
>> On Thu, Feb 6, 2020 at 5:45 AM Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>>
>>> Hi Prashant,
>>>
>>> On 6/2/20 13:17, Jonathan Cameron wrote:
>>>> On Wed,  5 Feb 2020 11:00:13 -0800
>>>> Prashant Malani <pmalani@chromium.org> wrote:
>>>>
>>>>> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
>>>>> which does the message buffer setup and cleanup.
>>>>>
>>>>> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
>>>>> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
>>>>> function.
>>>>>
>>>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>>>>
>>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - Updated to use new function name and parameter list.
>>>>> - Used C99 element setting to initialize param struct.
>>>>> - For second usage, replaced cros_ec_cmd_xfer_status() with
>>>>>   cros_ec_cmd_xfer() which is functionally similar.
>>>>>
>>>>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
>>>>>  1 file changed, 9 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>>> index d3a3626c7cd834..94e22e7d927631 100644
>>>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>>> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>>>>>                                           u16 cmd_offset, u16 cmd, u32 *mask)
>>>>>  {
>>>>>      int ret;
>>>>> -    struct {
>>>>> -            struct cros_ec_command msg;
>>>>> -            union {
>>>>> -                    struct ec_params_get_cmd_versions params;
>>>>> -                    struct ec_response_get_cmd_versions resp;
>>>>> -            };
>>>>> -    } __packed buf = {
>>>>> -            .msg = {
>>>>> -                    .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
>>>>> -                    .insize = sizeof(struct ec_response_get_cmd_versions),
>>>>> -                    .outsize = sizeof(struct ec_params_get_cmd_versions)
>>>>> -                    },
>>>>> -            .params = {.cmd = cmd}
>>>>> +    struct ec_params_get_cmd_versions params = {
>>>>> +            .cmd = cmd,
>>>>>      };
>>>>> +    struct ec_response_get_cmd_versions resp = {0};
>>>>>
>>>>> -    ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
>>>>> +    ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
>>>>> +                      &params, sizeof(params), &resp, sizeof(resp), NULL);
>>>>>      if (ret >= 0)
>>>>> -            *mask = buf.resp.version_mask;
>>>>> +            *mask = resp.version_mask;
>>>>>      return ret;
>>>>>  }
>>>>>
>>>>> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>>>>>
>>>>>      memcpy(state->msg->data, &state->param, sizeof(state->param));
>>>>>
>>>>> -    ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
>>>>> +    ret = cros_ec_cmd_xfer(state->ec, state->msg);
>>>>>      if (ret < 0)
>>>>>              return ret;
>>>>> +    else if (state->msg->result != EC_RES_SUCCESS)
>>>>> +            return -EPROTO;
>>>>>
>>>
>>> There is no way to use the new cros_ec_cmd here?
> When the EC does not support sensor fifo,
> cros_ec_motion_send_host_cmd() is on the data path. For instance, it
> is called 2 times every 10ms by chrome to calculate the lid angle. I
> would be reluctant to call malloc. Given it is well encapsulated into
> the sensor stack. Does it make sense to call cros_ec_cmd_xfer
> directly?
> 

Thanks Gwendal for pointing this, it makes totally sense, and I suspect this can
happen on other cases.

Just to make clear, my concern is not about not using the new 'cros_ec_cmd'
here, is about changing 'cros_ec_cmd_xfer_status' for 'cros_ec_cmd_xfer'. Also,
my other concern is how useful is the new 'cros_ec_cmd' replacing what we have
now if cannot replace all current uses.

My points of view are this:

* Actually we have cros_ec_cmd_xfer and cros_ec_cmd_xfer_status, use the second
one is better, in fact, we tried to move all the cros_ec_cmd_xfer to the _status
version in the past because makes the code and error handling cleaner. So I'm
reticent to get back to use cros_ec_cmd_xfer instead of cros_ec_cmd_xfer_status.

* The users of the cros-ec protocol sometimes they mallocing/freeing at runtime,
and sometimes they don't. IMHO *non* mallocing/freeing is usually better, more
efficient and faster. Would be nice to standardize this.

* If we want to introduce a new 'cros_ec_cmd', this should make the code cleaner
and ideally should be the way we tell the users they should use to communicate
with the cros-ec and not open coding constantly. Ideally, should be a
replacement of all current 'cros_ec_cmd_xfer*' versions.

* If 'cros_ec_cmd' *cannot* replace all the cases, it should be clear to the
user in which cases he should use this function and in which cases shouldn't use
this function.

* Finally, what pointed Gwendal, what's the best approach to send commands to
the EC by default, is better use dynamic memory? or is better use the stack? is
it always safe use the stack? is always efficient use allocated memory?

As you can see I have a lot of questions still around, but taking in
consideration that this will be an important change I think that makes sense
spend some time discussing it.

What do you think?

Enric


> Gwendal.
>>
>> I think it is doable. From looking at the code I felt the factors we
>> need to be careful about are:
>> - The function cros_ec_motion_send_host_cmd() is called from a few
>> other files, each of which set up the struct cros_ec_command
>> differently (reference:
>> https://elixir.bootlin.com/linux/latest/ident/cros_ec_motion_send_host_cmd)
>> - It is not clear to me how readability will be affected by making the
>> change to cros_ec_cmd().
>>
>> Due to the above two factors, but primarily because I wanted to avoid
>> making such an involved large change in this 17 patch series, I
>> reasoned it would be better to make the transition to cros_ec_cmd()
>> for these files in a separate patch/series.
>> My plan after this patch series is to work on this driver(perhaps we
>> can eliminate cros_ec_motion_send_host_cmd() itself?), and then remove
>> cros_ec_cmd_xfer() usage.
>>
>> WDYT?
>>
>> Best regards,
>>
>>
>>>
>>>
>>>>>      if (ret &&
>>>>>          state->resp != (struct ec_response_motion_sense *)state->msg->data)
>>>>
