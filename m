Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF7536FB8
	for <lists+linux-iio@lfdr.de>; Sun, 29 May 2022 07:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiE2FCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 May 2022 01:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiE2FCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2022 01:02:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F305FF3C
        for <linux-iio@vger.kernel.org>; Sat, 28 May 2022 22:02:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b4so8474268iog.11
        for <linux-iio@vger.kernel.org>; Sat, 28 May 2022 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5v4SGQ5y2d1CJi+3SGXCOhq50bilHoFFmnwE3S8gCRM=;
        b=Z5EU8WArcSeFGx6Ifboxx6Fwgb2xlls4fJUJxi8Bd+bWILHxlyBQz+5WDi1Z073/1A
         okACZB9QZot5+UTj2fTqnEHMXUc7YEf41OTS/JpYCF+jcFVPaqpWiQzgSBM6tC18pRme
         Lj5+nwc/nysWHgMt8GGO/QncGKZ0m4Ey1jv11bpLQ7LVQg9tavWK1Bw1wRO1DVHuA9d9
         95O+eWaQ3zCmxlZtcqqR6Pwexjs1peCwFUEmFc1/SgVVgMFJRCgparE9+bVh68lf1nDS
         l+Zps6sTD18jsRqFjqAqPzXv3WF+mkUIBU+WP0KsoA3rNoVXPhbFYR+FrrHN3NCQK45n
         vuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5v4SGQ5y2d1CJi+3SGXCOhq50bilHoFFmnwE3S8gCRM=;
        b=touXCm9LXu1wvB+KgquI1hhcDwh3lbxz4R7foZMxgbyq5U47s9x2VPUzMmeJP+vrbn
         U8x3InozbBxl4q5PAYJqc7RlnQaljIgqSnYjT1rh+EemfTqIQMhTgUCiBsgqrZONv3+w
         KA/yl/uEWBwN9by1A37ovAffTyWaIZB1VosXQIRE3GtdG35UeHZ/q+mV4u1NJxYgicCy
         T3Ythx9n3lVx+VSsXHTjZGc6gVu8x9GIV51UCMLKDTkBFBkd+5gv9jREDBJ1bc8E3BDf
         kOgtHbmmY+HV7xKq+nF2HNxYTmnMZDhQtP9kAwjsfBmCL5UjU2BLTyXho0WoMGB/ePxl
         lVXA==
X-Gm-Message-State: AOAM532kWrLkqTA46oU0l26qLwOCeOv4Hb7P8sY47nEGol03TUOmMIfV
        xT1IO/b+T2KjimOOeV+WqKFRBvOv6ncPYKe5fFOhHY1cZCOqfA==
X-Google-Smtp-Source: ABdhPJyUcpXQxshKhvxS0MFSroAxRC/OjcW9wQHGf7zMcMVdxTvmJf3T43qrcUFnr9y9wqYSOmNpE+y2SNG5ODo2wjE=
X-Received: by 2002:a6b:5a0c:0:b0:660:d32b:df5b with SMTP id
 o12-20020a6b5a0c000000b00660d32bdf5bmr17027918iob.39.1653800527532; Sat, 28
 May 2022 22:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220526134603.75216-1-alexandru.tachici@analog.com> <20220528175055.091c4ea0@jic23-huawei>
In-Reply-To: <20220528175055.091c4ea0@jic23-huawei>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 29 May 2022 08:01:56 +0300
Message-ID: <CA+U=DspiK92mSSq6M0fPo+19hPk+fA-BrvKmdmFOX_9YrO6jVQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] dt-bindings: iio: update maintainers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 28, 2022 at 7:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 26 May 2022 16:45:57 +0300
> <alexandru.tachici@analog.com> wrote:
>
> > From: Alexandru Tachici <alexandru.tachici@analog.com>
> >
> > Some of the emails in bindings maintainers section are not
> > working anymore. Update them with current ones.
>
> Hi Alexandru,
>
> Where possible for maintainer changes, cc the original person
> on their new email addresses.  Alexandru is still active on the
> list +CC.
>
> Now, if they don't reply I don't mind switching these maintainers
> over but nice to give them a heads up.

Unfortunately, I have a hard time these days keeping up with open-source st=
uff.
I may need to create a company that does open-source work to be more
present again.
It's ironic, because I read the Linux Foundation reports saying "open
source jobs are on the rise" and then I look around and it's not quite
the case.
It may also mean that non-open-source jobs are even more on the rise.
=C2=AF\_(=E3=83=84)_/=C2=AF

Anyway, for the series:

Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Thanks,
>
> Jonathan
>
> >
> > Alexandru Tachici (5):
> >   dt-bindings: iio: accel: ADIS16240: update maintainers
> >   dt-bindings: iio: adc: AD9467: update maintainers
> >   dt-bindings: iio: adc: axi-adc: update maintainers
> >   dt-bindings: iio: dac: AD5770R: update maintainers
> >   dt-bindings: iio: imu: adis16480: update maintainers
> >
> >  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
> >  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml      | 1 -
> >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml     | 1 -
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
> >  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
> >  5 files changed, 3 insertions(+), 5 deletions(-)
> >
>
