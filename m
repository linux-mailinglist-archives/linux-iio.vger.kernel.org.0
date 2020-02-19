Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008B716518A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 22:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgBSVZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 16:25:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39612 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 16:25:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so25332469oih.6;
        Wed, 19 Feb 2020 13:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCxKuFuKrKCmX1uT5gLX0bEHo5oCkRKj0kBnIt2u63M=;
        b=JOSVdHoDopCv2+s+Gwxv8k25oW01alnL8rsEPehJdZHCBrqL0N80WwQoaaz9AHW+PA
         0KO2TGqatqGX+qWzWK6Ryz4+hjS8pXRITKD+XuOEU6Q/wSmM58ReEZ7HhUIVKhdjbjfx
         FuUiEXFh+IqFPfDpDIaNqb6C66p1SgPCpsXMiiOMyauDQPeERoteJE/0aVMhva7pz9iH
         RwG4OjpVgFouZIJqeF2tYe1WXq+ea0zvjQ4C86r+Z3aUwuyP1lBOU9fEZQ1TkvfiN5TU
         lut4ClkW9EvFxUPED+XC/CoftERkR7TeESHQwef9KmSUVquSpgsO1x84UwYtub7saS5V
         6mng==
X-Gm-Message-State: APjAAAUP8xlDO0zPHh0Oi2WmQyv2rmCffSrQdLRqHiuBrPVa05zKin/1
        ANnlRhTbjx4VDl2map+z0w==
X-Google-Smtp-Source: APXvYqwDVCsW3U1t+AEF60kSVA4s4dd6NUwHx6X/WAXPqRa5l1ABP+U4U73fvsww73PFx1TuvezuaA==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr5717061oij.119.1582147538427;
        Wed, 19 Feb 2020 13:25:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm321464otl.71.2020.02.19.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:25:37 -0800 (PST)
Received: (nullmailer pid 29494 invoked by uid 1000);
        Wed, 19 Feb 2020 21:25:36 -0000
Date:   Wed, 19 Feb 2020 15:25:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Junho <djunho@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        michael.hennerich@analog.com, patrick.vasseur@c-s.fr,
        alexandru.Ardelean@analog.com
Subject: Re: [PATCH v2] dt-bindings: iio: adc: ad7923: Add binding
 documentation for AD7928
Message-ID: <20200219212536.GA29435@bogus>
References: <20200218110647.24758-1-djunho@padtec.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218110647.24758-1-djunho@padtec.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Feb 2020 08:06:47 -0300, Daniel Junho wrote:
> From: Daniel Junho <djunho@gmail.com>
> 
> This patch add device tree binding documentation for AD7923 adc in YAML
> format.
> 
> Signed-off-by: Daniel Junho <djunho@gmail.com>
> ---
> Changes in v2:
> - Fix the license header to "GPL-2.0-only OR BSD-2-Clause";
> - Change the Michael Hennerich email.
> 
>  .../bindings/iio/adc/adi,ad7923.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
