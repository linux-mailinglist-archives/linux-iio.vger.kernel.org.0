Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE64B6AD7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 12:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiBOLak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 06:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiBOLae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 06:30:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3597108579
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 03:30:24 -0800 (PST)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 112193F4B4
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644924623;
        bh=TQsWKxzWtW4CbZduV18nJ8RuXExNAqdKgvnVntrHDhc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ih4nybmos/dYj9ptGC8iIbrR2f0liEqTSJ7K5toAJyiI0DQbr488UQsDEHvUkOBVL
         Rel72W18wTWMaSFvUjpo+7TlK9i01THlKC/6k/DSkZvHICnVQRQ2xU2R+0HJrl4he1
         YHT4anh7KNyaz10OJKGaYVmYQUgDDUdyZKduLJf2Sx3QZScuF7A0Mo+VOvnyrSHFNH
         JiI+AimC3ocKRBnlzJ7TW+tz6pmJx5nN2ITd8FWoq48/Uwwq/9wavUQ9Kp+93d/dmS
         c5Fb7s8L/CbmzaajY7ADu/ULYKHT8Lpch8yJUYnrWsz689GU06n2OLnMgy64Bx0g+g
         SWO/AQdN/CHNA==
Received: by mail-oo1-f69.google.com with SMTP id q25-20020a4a3019000000b0031917d3fbd6so728930oof.18
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 03:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQsWKxzWtW4CbZduV18nJ8RuXExNAqdKgvnVntrHDhc=;
        b=jWNLeETVQS3rjs13kWJyK6q6yYfKeGcQsyVb9jQeDtQRZfX/H6CVoMj6wX3lOUo8fi
         3HyTrqt1sTwIt75Fxud+lxbxz0/qSHW7yapHFJ5QQSu4dopYPtdQAoDp8Lp8fb2AxSln
         fKdEdaii0CcrQ8XlBybC2Lp3wkdol5Hjlt9cXOzfqE/JvktqZbSVskjqp8xXYPbp45B2
         HCZk2gnLZDQyNxBr3oSQqdsJvU7KFeBExKHcNbclyn1asj47mYMr+Xob79ekSZDmeziF
         piooAEoKqbWD/KHiJh3FQCt2C0G9FrxgvG1v2HNI4WtrxHAdT4zpIw7RYpwD2gu4vzdb
         wsEw==
X-Gm-Message-State: AOAM531qkTqFb72YbBJg1vfn6y8KRro6H+yl8DZFUwFILRXQWnwWByLR
        GGxA7tw/C/plTErXUCghpSNosIYj3NCrVSsDzIkK+DnY5WITjIo+tf0gOZ51gSgE05t4FBcQVAX
        u26uzWh6FNVZ6JqTPYlao97kldvU+yIydmdaINN1pRRXWeXDooEqxRQ==
X-Received: by 2002:a05:6870:1019:b0:ce:c0c9:631 with SMTP id 25-20020a056870101900b000cec0c90631mr1163427oai.131.1644924621952;
        Tue, 15 Feb 2022 03:30:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSDV3cX4UNce8B0x7g5PwElp6clHoeO17u/5Wi9aFeC595MGFUPB0PzJhz/IbYfeFikE2Tp9YmYSfowWCVBTw=
X-Received: by 2002:a05:6870:1019:b0:ce:c0c9:631 with SMTP id
 25-20020a056870101900b000cec0c90631mr1163415oai.131.1644924621695; Tue, 15
 Feb 2022 03:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20220215042011.2266897-1-kai.heng.feng@canonical.com> <CAHp75VfBQPgrbuxazuoyDbFtGZR=rU5wqPhSXhkoiA_2HR1EHA@mail.gmail.com>
In-Reply-To: <CAHp75VfBQPgrbuxazuoyDbFtGZR=rU5wqPhSXhkoiA_2HR1EHA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 15 Feb 2022 19:30:10 +0800
Message-ID: <CAAd53p6tjWtKSqDDG_hjbFGKeR7-L3uYwgOTRNHfwAhmE8nV+g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: adxl345: Add ACPI HID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 15, 2022 at 4:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Feb 15, 2022 at 6:20 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > x86 boards may use ACPI HID "ADS0345" for adxl345 device.
> >
> > Analog replied:
> > "ADS034X is not a valid PNP ID. ADS0345 would be.
> > I'm not aware that this ID is already taken.
> > Feel free to submit a mainline Linux input mailing list patch."
> >
> > So add an ACPI match table for that accordingly.
>
> Thank you for the update, my comments below.
>
> ...
>
> > @@ -41,6 +41,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
> >  static const struct i2c_device_id adxl345_i2c_id[] = {
> >         { "adxl345", ADXL345 },
> >         { "adxl375", ADXL375 },
>
> > +       { "ADS0345:00", ADXL345 },
> >         { }
> >  };
> >
>
> This is wrong. First of all, on the left side you put the device
> instance name (which must not be in the ID tables, since the device
> instance name is "ID + instance number"). Second, the motivation of
> this is not clear, if the device is enumerated by ACPI, why do you
> care about board code?

I was uncertain on this at first, but later I saw some drivers use
this form (*:00) too, so I just followed through.

The intention is to accommodate adxl345_i2c_probe() without any modification.


>
> Just don't add anything to this table.

Got it.

>
> The rest is good, but consider doing the same for _spi part of the driver.

OK, will do.

Kai-Heng

>
> --
> With Best Regards,
> Andy Shevchenko
