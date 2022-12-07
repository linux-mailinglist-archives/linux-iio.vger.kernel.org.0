Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79D646130
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLGSgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 13:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 13:36:18 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D91EC63
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 10:36:16 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3e45d25de97so139558217b3.6
        for <linux-iio@vger.kernel.org>; Wed, 07 Dec 2022 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkCBMDlB3hXmQeitr6CrurlYhqpOvhf1O6xFonNtxQo=;
        b=Pj0CG1pyIpr6pqsivNG2FWlrW0K3xiy1hT4jNSjQvJHjeS6GZBsRrFqo9647GWmaiw
         JSPjPZZRUFvAnVbiUhBimguRFOXzVJwfb7ZngeznjR025w4IK6yDuCeIhKG5/HV0BeQb
         n3+WxW0n2ez+vrvcXYsegtuJVlDgD9tdis73WkkpQSXANiSEP4SetrLZrDHhPwk+hV+X
         dqpx5h03FurSXVxNt95ojrqYSAcPjbuYPL+yDe0FOOrcFn3UKImHOcjjS+HHDPI+6miF
         OkORjEdDExI0LWMAs5paMqseoVeIQ7nlGQ08/5MN0rzmw9Piywr1vcBFsD7DwxaHE5K2
         ESaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkCBMDlB3hXmQeitr6CrurlYhqpOvhf1O6xFonNtxQo=;
        b=taWyEgSqhYeYKsPga9aeghdQDxFT23vIOHV/aInNhsc/wGZR6sHdar0hufXbcEpAod
         As/73oNfN+m+FOtS9KdfqPiumKi7Dr2T48jNMftQLgvzIfED1JXFk+jec1YJ9sk5Zfwm
         5p0whiWwc1nUwSo/3e6/q+W2h+KKlEGL1qAoNa9SBgahYVyjqvQo6IndKWONb7rIKk1u
         iQHl0Aj46if9uE2Euluex+VKcVc/dhRHnWX/YeZXABGNwmmsfcEmrq8pqM+IzpXAMnFY
         LVywbkH0rJyRZGM1bLhv2faGaxM6qjX/p9qsBR7O8IaGkmpkUycFroCL+xFW/QhH9wLk
         eRvg==
X-Gm-Message-State: ANoB5pniRrSx40818eULLQi2u4LDbo2vECNQnZKP/YHKUsUXgHHTz8s9
        Xyi5aJa6HKmjSt6JSbGNLOBm0DDNnbHXSd2vzXIVTQ==
X-Google-Smtp-Source: AA0mqf4m5wZ2kYRrz+V6Su/X0hXGCCxugC1U+MQcs7ps/3PXHRak9VUu+C2HY/CsHAxhi0AWrkS67g/lonIWB716Wek=
X-Received: by 2002:a81:6c52:0:b0:370:4c23:eacc with SMTP id
 h79-20020a816c52000000b003704c23eaccmr21656043ywc.127.1670438175478; Wed, 07
 Dec 2022 10:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
 <20221204061555.1355453-2-dmitry.baryshkov@linaro.org> <20221205220433.GA2684995-robh@kernel.org>
 <E5C1A37F-5758-4026-9412-F13760C465D0@linaro.org> <20221207170753.GA2402110-robh@kernel.org>
In-Reply-To: <20221207170753.GA2402110-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 7 Dec 2022 20:36:04 +0200
Message-ID: <CAA8EJpoOuJqK7zGsU2C9Y1ZB-Lb5TvXcL30be6uVodOy=M6T5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: input: qcom,pm8921-keypad: convert to
 YAML format
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Dec 2022 at 19:07, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 06, 2022 at 05:20:16AM +0200, Dmitry Baryshkov wrote:
> > 6 =D0=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2022 =D0=B3. 00:04:33 GMT+=
02:00, Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >On Sun, Dec 04, 2022 at 08:15:52AM +0200, Dmitry Baryshkov wrote:
> > >> Convert the bindings for the keypad subdevices of Qualcomm PM8921 an=
d
> > >> PM8058 PMICs from text to YAML format.
> > >>
> > >> While doing the conversion also change linux,keypad-no-autorepeat
> > >> property to linux,input-no-autorepeat. The former property was never
> > >> used by DT and was never handled by the driver.
> > >
> > >Changing from the documented one to one some drivers use. I guess
> > >that's a slight improvement. Please see this discussion[1].
> >
> > Well, the problem is that the documentation is misleading. The driver
> > doesn't handle the documented property, so we should change either
> > the driver, or the docs. Which change is the preferred one?
>
> The preference is autorepeat is not the default and setting
> 'autorepeat' enables it. You can't really change that unless you don't
> really need autorepeat by default. I can't see why it would be
> needed for the power button, but I haven't looked what else you have.

It's not a pon/resin. this is a full-fledged keypad. For example for
apq8060-dragonboard:

linux,keymap =3D <
        MATRIX_KEY(0, 0, KEY_MENU)
        MATRIX_KEY(0, 2, KEY_1)
        MATRIX_KEY(0, 3, KEY_4)
        MATRIX_KEY(0, 4, KEY_7)
        MATRIX_KEY(1, 0, KEY_UP)
        MATRIX_KEY(1, 1, KEY_LEFT)
        MATRIX_KEY(1, 2, KEY_DOWN)
        MATRIX_KEY(1, 3, KEY_5)
        MATRIX_KEY(1, 3, KEY_8)
        MATRIX_KEY(2, 0, KEY_HOME)
        MATRIX_KEY(2, 1, KEY_REPLY)
        MATRIX_KEY(2, 2, KEY_2)
        MATRIX_KEY(2, 3, KEY_6)
        MATRIX_KEY(3, 0, KEY_VOLUMEUP)
        MATRIX_KEY(3, 1, KEY_RIGHT)
        MATRIX_KEY(3, 2, KEY_3)
        MATRIX_KEY(3, 3, KEY_9)
        MATRIX_KEY(3, 4, KEY_SWITCHVIDEOMODE)
        MATRIX_KEY(4, 0, KEY_VOLUMEDOWN)
        MATRIX_KEY(4, 1, KEY_BACK)
        MATRIX_KEY(4, 2, KEY_CAMERA)
        MATRIX_KEY(4, 3, KEY_KBDILLUMTOGGLE)
                                        >;

> Of all the no autorepeat options, I prefer 'linux,no-autorepeat' as I
> find 'input' or 'keypad' redundant. But Dmitry T. didn't think it should
> be a common property at the time.

We have not used any of the options in the in-kernel DTs. However the
driver for the keypad has supported the 'linux,input-no-autorepeat'
since March 2014. I'm just changing the docs to document the correct
option. I can split the patch into two distinct patches (one for the
bugfix, one for conversion), if you think that it would be better.


--=20
With best wishes
Dmitry
