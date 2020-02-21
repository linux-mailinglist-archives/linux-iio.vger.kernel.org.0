Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1E166B45
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 01:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgBUAGb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 19:06:31 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42236 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgBUAGa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 19:06:30 -0500
Received: by mail-io1-f41.google.com with SMTP id z1so432736iom.9
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2020 16:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjnxCY+XiITmYjZv2MmWpX2vHzA6oAIhEU7VOrXxb1s=;
        b=lutodXfXkQ5NXhzTzooH4Yr03b4mxtlDPbKLCO4BaObZBR+/0RMpJlbnnfouJ09SRa
         ehcXipqprQ2fzXQFyaK62wJ4Ah4Q+Xa1kHjLiTHcqDcfR3aYkotgKi0LhpRh/jzMlTzZ
         YKAYKuT9ayCdOg+w1ojngSWE0E/clKpY4kBnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjnxCY+XiITmYjZv2MmWpX2vHzA6oAIhEU7VOrXxb1s=;
        b=VxY+LspkVSuKGv2G0CAZKZU0IW+ToZuNuSkMNvm0P2EfHe1t2EkbrWAKnXJYp1vIJr
         op07JpV0wBuiKPyXYX4wEFyztpIr7JQaJ+bIbM59dt8cIUrCJ1CACimbuB8Wj3MlX7u+
         +ypQLoBZuQ6B4WWW5GE+TxTSKRj4aThv9CmhfDjNyRiR6WEbwl7ow5R940D0kKVqwY6x
         kSsD3mJJkuK9qkX1D4WU3vtUqewuflrpSSbYtN+aX/Sa2BjU5JRTCI1MnzEJinOUu+Mr
         CTP5Tdc1AzlHFO5INIITkLVboM92ObbxV4rwf+cubhAfrzUpqhFtRH8oereyM/oGxc7R
         t7Mw==
X-Gm-Message-State: APjAAAVuzFsvVrLNz7A8aHEPunjsRFVMS0dDi8nal7fsIA0RMpdf/YsK
        nWRvITdx61+gobx+y2JKWT3HxFgXrDb492Pq5hiFrw==
X-Google-Smtp-Source: APXvYqykZHTmxo/okBXfbLrfb90w7Nsd/MR2HbotsYje/Yl7SH7PrCJYCDQB95gsoOvyCyJ0OsfNU5S+yGt/CxrNlLk=
X-Received: by 2002:a02:9203:: with SMTP id x3mr27449947jag.62.1582243590010;
 Thu, 20 Feb 2020 16:06:30 -0800 (PST)
MIME-Version: 1.0
References: <CH2PR12MB4181730FBF2DAE98E17ADBA9C4110@CH2PR12MB4181.namprd12.prod.outlook.com>
 <20200219183837.00002aac@Huawei.com>
In-Reply-To: <20200219183837.00002aac@Huawei.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 20 Feb 2020 16:06:19 -0800
Message-ID: <CAJCx=gkcB=EQdNT7AaK9xG0jBhAW34L1CLOfWbOnpJYx=8AYdQ@mail.gmail.com>
Subject: Re: Question about pressure sensor driver data processing
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 19, 2020 at 10:38 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 18 Feb 2020 15:59:26 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>
> > Hello,
> >
> > I have a question concerning a pressure sensor driver I am currently
> > writing.
> >
> > The formula to get the real pressure in Pa for this sensor is quite
> > complex. It depends on the measured temperature and would be far
> > better done in floats rather than in integers.
> >
> > The formula is too complex to be expressed with only scale and offset
> > factors. And the factors are not fixed since it depends on the
> > temperature.
> >
> > Would it be acceptable to have a driver than returns the raw data
> > without processing? Meaning data that have no unit and require a
> > processing done in userspace? That would be much more efficient for
> > sure, but it would not output really useful data without the
> > processing.
>
> Whilst it isn't nice, we have examples where this is already the case.
> The heart rate sensors are similar in that they have very complex
> conversions.

Don't forget the chemicals sensors that depend on temperature as well. Although
to be fair most of those take input into the 'sensor hub' to do the
calculations in their
black box.

- Matt

>
> It is certainly better than being unable to support the driver at all,
> but it does mean you won't ever be able to use it with generic code.
>
> Generic code tends to assume the scale is constant as well, so probably
> wouldn't work anyway :)
>
> >
> > Or a driver that return an input processed data and a raw data that
> > have no unit and requires the processing? If we can return raw data,
> > we should be able also to add buffer/trigger support to the driver.
> > Otherwise that would be quite tricky to return the processed data in
> > the buffer.
>
> Hmm. It is messy so if you actually expect to add buffered support, then
> we will need special code in userspace for this device anyway.
> We do have devices that jump through a complex conversion then pack
> it into a buffer, but that is also somewhat of a hack.
>
> For now at least, go with the raw output only.  It may be one of those
> exceptions where we do support both processed and raw outputs in the
> longer term if there is clear need for generic code with this device.
>
> Jonathan
> >
> > Thanks for your feedback.
> > JB
>
