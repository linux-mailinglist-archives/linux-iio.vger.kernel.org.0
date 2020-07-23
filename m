Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA69F22B539
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgGWRv5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 13:51:57 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46343 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRv5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 13:51:57 -0400
Received: by mail-il1-f194.google.com with SMTP id p15so5023712ilh.13;
        Thu, 23 Jul 2020 10:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5WLGCR9bENskIVOBPRF9vm9x8PVvKK0z289Y6Byz2E=;
        b=qUL4PGomSL3Fy5VnKEDjgySwOaD1lnVKtprDuIqtZjdusR0jsdbzbS4sYtBRf/BazQ
         j3X6Xg6psyjnxq7VyePa6wHr3o5RNfsH3K6hQ+fsOlVnyOGoJ2Lzi9S/eKvGoybn3uk6
         +6mB8qbCeoJiJKjpkcpwqNeV1jSWPzGXpyFmQzDngaHHfJ3BCuxmb2K+qOULyue8pL22
         uNQTo3SDcbuIAakF81BdUQ9ILaNiGFnq4HEDsBUbSVNII+qvLFIT1FBaMgb7IBxbEw3+
         TtAnM6vNzLTpw1E1ojZBkU2S9rUSOwULj7RcVoM03WUc0OFkIpFD0rKbkp4/wbB/HGeC
         Veww==
X-Gm-Message-State: AOAM531f18xFtlhD6jHIydFiktkfbb+Iu5Shl86AYgW+/L4+MU5kF3aU
        sqS02qqr/QrNuREjSMFQDiyStCNvvA==
X-Google-Smtp-Source: ABdhPJy4UhjxUY92EDPNT8DAeOKClLwsYD+g1sMx0AOYGqyOz57wkAUe0Kpn+xwvgX8eOHJTKoOfPw==
X-Received: by 2002:a92:db44:: with SMTP id w4mr5879743ilq.306.1595526716435;
        Thu, 23 Jul 2020 10:51:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r6sm1786276iln.77.2020.07.23.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:51:55 -0700 (PDT)
Received: (nullmailer pid 602456 invoked by uid 1000);
        Thu, 23 Jul 2020 17:51:55 -0000
Date:   Thu, 23 Jul 2020 11:51:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     darius.berghe@analog.com, linux-iio@vger.kernel.org,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dragos.bogdan@analog.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: gyro: Add DT binding doc for
 ADXRS290
Message-ID: <20200723175155.GA602402@bogus>
References: <20200721181937.27101-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721181937.27101-1-nish.malpani25@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 23:49:37 +0530, Nishant Malpani wrote:
> Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
> 
> Changes in v2:
>   - use 'const' instead of 'enum' while setting the compatible string
>     since only a single item is expected
>   - add 'additionalProperties: false'
> ---
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
