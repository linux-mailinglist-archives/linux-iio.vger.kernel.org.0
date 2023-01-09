Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABF662FDA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjAITEz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 14:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbjAITEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 14:04:52 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E738AF6
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 11:04:51 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id f26so2029582uab.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2023 11:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1ZZT5JYyyHdPaJbyVu0BenKa5tLViKGPOSVHMRlwf8=;
        b=S/0qeuAi3UEzIu0Fs0Rk66dsr9scULTECQEypgOyulkmVVN2n0DJrrAHnU/TvwV6sJ
         Bgw98U7zMUD8TkpUwvbTltuWuTwKIIdXtX4kOcEWLVh5AnKEykF6vTb8UywHtxB42dpN
         ZAy7sFu/VOxUqU+wzwsm8D3Cj5WgAwQdp0u6SWkiCs6991dYIXwGGSYSwenqMRXtnzRP
         WDdy12DsIeHmHYhNQeRtn8R+xf9rpmH/vkP82NANU7VP8+Qo5sJbH2ifxJuS5tW7mc4f
         JjOz842etzqfZzy1N1hwGwrvl7QDBAABXzFrqqacdfzte9+G+6Q/xOay8LwA8w/PDyXc
         +XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1ZZT5JYyyHdPaJbyVu0BenKa5tLViKGPOSVHMRlwf8=;
        b=3xLhc7WPVlxtFhcCjtkC9xgQ/PgKMrx9pUi0bqutfoRTFInCexIgojfiFanm6wiJFY
         mhf0WvzJ83PPa2UpAKvYiuAUBIHHSxcIH0AYxgYBfJV4AFDErZpKoe329OKHPAVnoX/0
         wPcKAQvmZBp1zJkmGpmSPIzQgLYhaOtEdjWzU6b5Pz1L7QK1fI/HymbhypyxGPRf11MQ
         NE8JN8aamQ5infiZrb130VGgR2k10ZUfgzEuPn34KbRPQIXP4CMlArcVM9RHsoRT30Ph
         9VTm+V8Pnn2LoUb8M36eVF7UHygDAhyIhZM5HtcK5ZGP61kSE3KfdNCuS2dFBcNp1oif
         4jfA==
X-Gm-Message-State: AFqh2krW62Fu1tu6NpQbv6yvtHjZk+4S+6/3OF0pgVLMlXQE8+3rhUtM
        yzoB1xGZ+Os5SWdvAtZ8DMF3sN+w72LOaZDV/pc=
X-Google-Smtp-Source: AMrXdXtYu3c7HxEDSm8iGl/uku5Y+ELRfLf7Wg0Zep/t6dKLFh2hV9uKoolKKF02/fOflS3XUnGDhru5Rfn0hsO8lPo=
X-Received: by 2002:ab0:1301:0:b0:444:2123:f8df with SMTP id
 g1-20020ab01301000000b004442123f8dfmr7319319uae.86.1673291090289; Mon, 09 Jan
 2023 11:04:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei> <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
 <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com> <Y7xO+WDQkvXIxvnw@smile.fi.intel.com>
In-Reply-To: <Y7xO+WDQkvXIxvnw@smile.fi.intel.com>
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Mon, 9 Jan 2023 11:04:38 -0800
Message-ID: <CAFqHKT=5vFE2nrVDLqZ_edxxFin7iKe4go-vvmGseSY2EdizjQ@mail.gmail.com>
Subject: Re: BMI0160/260 conflicts
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        liudk@softwincn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

They typically communicate through discord or whatsapp. I've sent them
the link for the thread a few times and I've asked for an email
address I can CC on the LKML so we'll see if they provide one. I don't
think this will be an issue, from them at least, in the future. For a
bit of history, the original tablet was designed by a different team
which they were obligated to finish through an IndieGoGo campaign
after the company was bought out halfway through production. All
subsequent releases from AyaNeo (7 models by my count) have all used
the BMI0160 ACPI ID. I'm personally more concerned personally with GPD
having released new products over a year later using the same Realtek
ACPI ID, and currently sending out engineering sample units of a
second model. I've included my GPD contact in this thread for their
awareness.

On Mon, Jan 9, 2023 at 9:29 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jan 09, 2023 at 07:42:01AM -0800, Derek John Clark wrote:
> > On Mon, Jan 9, 2023 at 3:38 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > > > On Sat, 7 Jan 2023 19:51:59 -0800
> > > > Derek John Clark <derekjohn.clark@gmail.com> wrote:
>
> ...
>
> > > > > Remediation:
> > > > > I have reached out to the aforementioned companies about releasing
> > > > > updated BIOS for each of the respective models to correct the DSDT
> > > > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > > > BIOS for testing.
> > > >
> > > > Great.  Hopefully that means that the scope of problem devices from
> > > > these manufacturers is not going to grow too much going forwards!
> > >
> > > Wow, you have Ayaneo response?! Unbelievable!
> > > If they answering to you, can you ping them on [1] please?
> > >
> > > [1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/
>
> > I've been knocking on this door for a few months now. They recently
> > sent me a test BIOS with the alleged fix for testing. Hopefully they
> > do a wide release once it is fully validated.
>
> At least they reacted to your knock, that's why I'm asking you to ping them so
> they would know that they have an issue with the ACPI ID for the accelerometer
> device.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
