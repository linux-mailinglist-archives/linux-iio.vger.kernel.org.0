Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB0A71AD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfICR3l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 13:29:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34763 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICR3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 13:29:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so18421248wrn.1;
        Tue, 03 Sep 2019 10:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1y/QzUkCcqpWnaaB2UPlBL6rkcc+2weJiERqBvIAqW8=;
        b=MryhOSBGWlQz1kkg3QeUJSHxIud9ulNj676luGixnwIsJunfQ/raQ0UOMW5ZnTpZAB
         nL7BC79A/NcxDJ3OUQXXoremlBKrBeI5fUCicnubhX8DMXFAOVhdJNPmQEbSCNJ5MGxR
         bPOU2d0JfdPhfBG6nd1WbJmTXBQGZ1eFYpKbljGLPT4Yd/g/CH3mTd5otKm3BcpTDuXW
         9f7n0EASbxwMzkR8a3H4H7PvbT4ueAR+q2PFja9KwbGI8Zx8Wr1FMj31ZedcESNftj1Q
         1WDuiNrpyxCPSwIKRNRLnL9+5MgH9PE9jC/0aKhQAr3TL1xwbLpBll7N5P/RtPWbj0J0
         B8/A==
X-Gm-Message-State: APjAAAWSeWOFMDobF0XeAkjlgkkwCHYGjrCqLO6SLpiKIFp7e8fsCq6M
        JzfgRFIxJz6vI8sF9Vgpmw==
X-Google-Smtp-Source: APXvYqxjsJYbE9ohCD01WYDc+yGRZ8dFjprGZ4Y0cLOYuKvgEwksgp61q+aQrJWH5lax8biar1g1TA==
X-Received: by 2002:adf:db01:: with SMTP id s1mr35665426wri.164.1567531779299;
        Tue, 03 Sep 2019 10:29:39 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id o9sm15518959wrm.88.2019.09.03.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:29:38 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:29:37 +0100
From:   Rob Herring <robh@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, lars@metafoo.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH V4 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
Message-ID: <20190903172937.GA15494@bogus>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
 <20190902130831.23057-4-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902130831.23057-4-mircea.caprioru@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 16:08:31 +0300, Mircea Caprioru wrote:
> This patch add device tree binding documentation for AD7192 adc in YAML
> format.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
> Changelog V4:
> - remove the const value from avdd and dvdd supply
> 
>  .../bindings/iio/adc/adi,ad7192.yaml          | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
