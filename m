Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210642DB226
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 18:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgLORED (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 12:04:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38672 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgLORDx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 12:03:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so15582265otq.5;
        Tue, 15 Dec 2020 09:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=my6Pxc4nWMm/kaW+tIaaU9D3enZgF/nrG6Uu+JTXzgg=;
        b=pw3qTeCSXPTWUtdautPN4xmBHPXYEkPAEzTVyq9gPtRk7Jfy+UeHp8w/KHQpKHIWVz
         daXPXT/ou1s8uNcSKbjSL7CxIDM2aOsAr7tqFtcSpbJK6cPjmH7fuh4qxu4CKJ7dlzZG
         TUzIK9Z4Pkp9Us1bdiNLFLl6yVvG3DMUsbY7yChgqfrtv9A2EQXQCLJ4Rtb0zvlm6Bck
         tBn1NzWw9+F/NfxW6nF7vf4IKam2p8iBbCPCr0lwihoDRg4/MrJ/1I2U8tevIqfIb/if
         Lz+oo+LcLdcdrVd+6T+7ePnJSxfh0Y6+DfI9C5rbNUtFYJifuMmvrn8a4S68KRNGXju2
         hqEQ==
X-Gm-Message-State: AOAM533MsVk0+y9AGk2LrLj07pfmeSOJn3QFUfJZQLvsGZfy5chpV8ul
        bAigRVtVz0FtsedMj4eSew==
X-Google-Smtp-Source: ABdhPJx6lB0dGGnpDRZ0c2GBFqFaV2FbGAk/IHanBIR3hNxEwfV7eOIs5rkzPN730rry3PyWao9Xew==
X-Received: by 2002:a05:6830:1493:: with SMTP id s19mr23920350otq.175.1608051790524;
        Tue, 15 Dec 2020 09:03:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s26sm541786otd.8.2020.12.15.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:03:09 -0800 (PST)
Received: (nullmailer pid 4028590 invoked by uid 1000);
        Tue, 15 Dec 2020 17:03:07 -0000
Date:   Tue, 15 Dec 2020 11:03:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     devajithvs <devajithvs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Robert Yang <decatf@gmail.com>, devicetree@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: kxcjk1013: Document
 regulator supplies
Message-ID: <20201215170307.GA4028538@robh.at.kernel.org>
References: <20201213172437.2779-1-devajithvs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213172437.2779-1-devajithvs@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Dec 2020 22:54:35 +0530, devajithvs wrote:
> From: Devajith V S <devajithvs@gmail.com>
> 
> kxcjk1013 devices have VDD and VDDIO power lines. Need
> to make sure the regulators are enabled before any
> communication with kxcjk1013. Document support for
> vdd/vddio-supply to implement this.
> 
> Signed-off-by: Devajith V S <devajithvs@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
