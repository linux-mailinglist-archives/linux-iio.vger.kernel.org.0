Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9986C921E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfJBTOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 15:14:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38208 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfJBTOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 15:14:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so139729qta.5;
        Wed, 02 Oct 2019 12:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYeIAOr0O2GzwhIQebU4JbTctyaMpwrHb0mqy++v8SU=;
        b=JZSP4I99zyp6DFBDWe700taNhwbSckj60qh5/zkX+B1RwA3csZGKvNalg94RYP4YIi
         cESL97hoFrnYa8/naVIGPno0zy6k9IhW9h8PbnCxj6qYTFJWm7bf10Aj1uTsprc0KfdG
         BEEDM6h+HRH9qLbkLAdrHuaHg1IbGj+Y+EGjz2hxI2w/FKo7RTM2kMQ3frLp41bAOgmo
         tQS69/wr742bJTI25uDySjqEP0+Nt2P0iWNzJY2PwGV3ouIl+b3SryApo9YO9c/w/3Vq
         MyqzVxEi0/F6LUDwVQkYFM/eVUd22xmgOVrgxgsXjNwqeqkNddxMvr1lZsNXpQZMUHXe
         3VSw==
X-Gm-Message-State: APjAAAWvVfkR31Yj+E33L2s9J62XGdXM23nvr0UHrBw+TBW3P5G5VQ5n
        y84XxudQv1bZjQ5fpXpimw==
X-Google-Smtp-Source: APXvYqyhhsNY51Xey/nHDN3yGdoUxojAd0nvSiIZmkQVHDRlC2RKzgcJxy8najeg8nN6FwEY12vjkw==
X-Received: by 2002:ac8:1a56:: with SMTP id q22mr5922497qtk.386.1570043670777;
        Wed, 02 Oct 2019 12:14:30 -0700 (PDT)
Received: from localhost ([132.205.229.212])
        by smtp.gmail.com with ESMTPSA id 56sm225646qty.15.2019.10.02.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:14:30 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:14:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: ad7192: Fix DTC warning in the
 example
Message-ID: <20191002191429.GA18511@bogus>
References: <20191002144542.114722-1-mripard@kernel.org>
 <20191002144542.114722-2-mripard@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002144542.114722-2-mripard@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 16:45:42 +0200, Maxime Ripard wrote:
> The example contains an SPI bus and device, but doesn't have the
> appropriate size and address cells size.
> 
> This creates a DTC warning when the example is compiled since the default
> ones will not match what the device uses. Let's add them to remove that
> warning.
> 
> Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

Rob
