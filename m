Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB6678BE9
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 00:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjAWXSM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 18:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAWXSL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 18:18:11 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6713507
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 15:18:10 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id jr19so10495375qtb.7
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 15:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wdlyZ9rT2ydR7flNpHZe1XEeAgVGxlcAPT5DY/7RdGw=;
        b=Wcbdmjpc2+Zezt9SjzJhaAPjgE2kW6y4jYLHi9sguPEdt0tjlwq4HdTgn3QnAXlzB9
         l72VgiQ4dWTTCRi9hOoKf2s5iftOWIRrlaieyH44J9AhIALimt3a/vdSItHKKvpsi1oX
         +Yjv505GMY3JttHLuddbN41Wyu+UC+wAR6F38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdlyZ9rT2ydR7flNpHZe1XEeAgVGxlcAPT5DY/7RdGw=;
        b=zQJglOyk2Il6NqDVtgHwwO2f2LRDFNGrw+I0zy6rv/do6wgzgdzLVleo1xTtjnuLnn
         N6I070B2NfTrHcmww1ipoomUfYqf6s9l24EI0WvivfDlvf2WbDtLXLJ7qaZ5thDVtZ6o
         w3S6UNma+GJIOjAqKSuPtds2eDP+7aFDAFpcqN5lV/t00Vd6WCHYfYSULuBJ8c23nI+4
         SF5su+L+FE+/TUdayZOlQWqs+b4PxlRIfSFadDlRHlpoS0QNpfIQadxtUyxjSQ6Vrcid
         Zc64aITgUMHxZq5v2p4GtYI9GXS+B21vN82MNuoD2ehrPKmjqGqkRqGJwR2GrZnYjOAZ
         Sr2A==
X-Gm-Message-State: AFqh2koHUedgLzvZxCzBxKr2396SFguZ+Tm98u6/aVJkh6QluE3Hk7VT
        qsyDOvTd2k99ro/n2zAylPk6+SVFDc1SYSCx
X-Google-Smtp-Source: AMrXdXsLvSK2cx9ZNnQUkexEpC9TxyXrzRdhkuLkHx52TNHZorItQE8ZeNwYQTqzLoa1yEuOxCmy3Q==
X-Received: by 2002:ac8:754d:0:b0:3ae:95c:8486 with SMTP id b13-20020ac8754d000000b003ae095c8486mr34237940qtr.64.1674515888773;
        Mon, 23 Jan 2023 15:18:08 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id n6-20020ac81e06000000b003b7ea9814b9sm204951qtl.10.2023.01.23.15.18.08
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 15:18:08 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z9so7235876qkl.13
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 15:18:08 -0800 (PST)
X-Received: by 2002:a05:6638:378c:b0:3a7:dd8b:54e5 with SMTP id
 w12-20020a056638378c00b003a7dd8b54e5mr1388544jal.8.1674515537964; Mon, 23 Jan
 2023 15:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei> <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
In-Reply-To: <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Jan 2023 15:12:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WVEfi2u-uHcZAoMd4HXPcZrwb95HQzTE8V6YmAW9mhPA@mail.gmail.com>
Message-ID: <CAD=FV=WVEfi2u-uHcZAoMd4HXPcZrwb95HQzTE8V6YmAW9mhPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 8:35 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 22.01.2023 18:24, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 12:06:23 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> >> The node name can contain an address part which is unused
> >> by the driver. Moreover, this string is propagated into
> >> the userspace label, sysfs filenames *and breaking ABI*.
> >>
> >> Cut the address part out before assigning the channel name.
> >>
> >> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> >> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > LGTM, but given it will have ABI impact, I'd like to hear from
> > Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> > who has touched this driver fairly recently.
> + Doug
>
> Unless the Chromium folks relied on the old names (they're the
> only ones I can think of that actually could have tapped into
> this), I say green light!

Thanks for the CC. I _think_ the only place we use these ADCs is for
certain thermistors and I think that those are all just hooked up in
the device tree, so the channel name doesn't matter. I'll also note
that no Qualcomm Chromebooks are shipping with anything newer than
kernel 5.15 right now, and (I checked) the ChromeOS 5.15 tree doesn't
have commit 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device
properties"). Thus, even if I'm wrong and the name is used someplace
hidden then the "old" name would be better for us. I haven't tested
the patch myself, but it sounds as if ${SUBJECT} patch is actually
moving us back to the old name.

+Matthias to keep me honest since he's spent more time with the ADCs.

> Konrad
> >
> > Mostly I want to be sure they know this exists before it causes surprise.
> >
> > Jonathan
> >
> >> ---
> >> v2: rephrased commit message (Marijn), fixed compilation issue (Marijin)
> >>  drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> >> index e90c299c913a..c2d5e06f137a 100644
> >> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> >> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> >> @@ -628,12 +628,20 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
> >>                                  struct fwnode_handle *fwnode,
> >>                                  const struct adc5_data *data)
> >>  {
> >> -    const char *name = fwnode_get_name(fwnode), *channel_name;
> >> +    const char *channel_name;
> >> +    char *name;
> >>      u32 chan, value, varr[2];
> >>      u32 sid = 0;
> >>      int ret;
> >>      struct device *dev = adc->dev;
> >>
> >> +    name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> >> +    if (!name)
> >> +            return -ENOMEM;
> >> +
> >> +    /* Cut the address part */
> >> +    name[strchrnul(name, '@') - name] = '\0';
> >> +
> >>      ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> >>      if (ret) {
> >>              dev_err(dev, "invalid channel number %s\n", name);
> >
