Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B6C231553
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgG1WGp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgG1WGo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 18:06:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C2C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 15:06:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l63so13015886pge.12
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tjuX+pFwhvhhgmdt7C5E6lKYvSKSrNHXExZ9GWsVSnI=;
        b=N6wAtpNOFmizd34oOwQzDBKa5iHjGcYvbPkHG549PxO5PlcZ6n/Yxp+E93o24GQcA8
         CaMeuDWeJkA9kLdYhpa5Mfg7Lb8i21veUpCeUB6z8wxaZ3yaj6oWeu8Z6l9aRw4dYXH0
         dNqz9b6XcDJaC96nzBpPsCNlSiwIIZTWWTbJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tjuX+pFwhvhhgmdt7C5E6lKYvSKSrNHXExZ9GWsVSnI=;
        b=p/QgmKHVnZRFvv4kvH5dIQQqO9oK5klCBejf9o4o20WA/PqYFLfpnqqku6MPX0Ka+K
         K1VYGyYqyFaraTXJSJbX2WxtdtFuGcjzvdrxAKniQ8hE0UAJ20nMXa+A9wWGv8q6daUM
         rICI2n/BARhxFyhY+4ynHjChmeIZV+uzfDDtq3HV7byaxfdOyXvFQnd9jtRqu/i8NQ15
         mSOh1vDGB6FOobspWV1OrGDXeTLn+T58VW/KCClwHxawS6QGNa8aFscEgyM84GhjK8cd
         K0MGO2/ymkQQ4uLbEGx2W3A6Z/W6rLjt2yMLNwWZRVngRD1Egs9WJ9IlV9InMP3t/q4n
         5nHQ==
X-Gm-Message-State: AOAM532kB6gOEPT/JYGL6Rr7TDFRZPY4sgxPTFCnuyJ1WJ71lRWkkmud
        AMlBkAnn2WTQXuCTevSLxjB2qg==
X-Google-Smtp-Source: ABdhPJxm2jSMp9UWBjwpogfSuRsV8etm/nCasMNF7xayH25Gtdpeobo52Xb6XBNuSHD9IB7TeitWdg==
X-Received: by 2002:a62:be02:: with SMTP id l2mr25990420pff.163.1595974003708;
        Tue, 28 Jul 2020 15:06:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id m6sm111594pjb.34.2020.07.28.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:06:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.1.I3bf8ece8c303bd9ecfc1573464cdacc47d73784b@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.1.I3bf8ece8c303bd9ecfc1573464cdacc47d73784b@changeid>
Subject: Re: [PATCH 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 15:06:41 -0700
Message-ID: <159597400172.1360974.7831683364002070743@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:44)
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx93=
10.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> new file mode 100644
> index 00000000000000..ba734ee868c77f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech's SX9310 capacitive proximity sensor
> +
> +maintainers:
> +  - Daniel Campello <campello@chromium.org>
> +
> +description: |
> +  Semtech's SX9310/SX9311 capacitive proximity/button solution.
> +
> +  Specifications about the devices can be found at:
> +  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
> +
> +properties:
> +  compatible:
> +    enum:
> +      - semtech,sx9310
> +      - semtech,sx9311
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The sole interrupt generated by the device used to announce the
> +      preceding reading request has finished and that data is
> +      available or that a close/far proximity event has happened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply
> +
> +  svdd-supply:
> +    description: Host interface power supply

I think we need to add #io-channel-cells =3D <1> here as a required
property.

   "#io-channel-cells":
       const: 1

> +
> +required:
> +  - compatible
> +  - reg

And=20

  - "#io-channel-cells"

> +
> +additionalProperties: false
> +
