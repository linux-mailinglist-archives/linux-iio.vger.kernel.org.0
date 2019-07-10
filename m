Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2826647A0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfGJNxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 09:53:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39230 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGJNxS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 09:53:18 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so4861903ioh.6;
        Wed, 10 Jul 2019 06:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJFaTrOR0uVU6CXAPbL0od+sFegWooZqjYvBbrJeUlo=;
        b=uFlLGdvJ8xOKNblm7PHytWslGKTVaMbBdjIcSt6HSVZDSDs0gHJ64LNCr1tT5xrqEw
         tpIeTyekxFzN9JxlYAktlWQGL0VK+DV/dAm7aFRut1uTAUYoyHbJ00PF/y4CFNFHOJV5
         VdWYy/yumMaH1DymxmunMhH1gRAmxgYmCFd/fWe49voPpe4RSDqfdlf5pBgGuLrFCgC3
         zFtwXTey173ib28RIc0nQKVnFTvtDZP5lgSZhQlRc62qw2K1eRLiWRttx6+1QfbOoKDL
         hwZ677zNNuNcVIynYKBD599Pk4XU1EgLNMZirYyXjewyW3Jle32CzHloyiMNTbpWUOD2
         ts5A==
X-Gm-Message-State: APjAAAU6u3HYycf0jdw+3vvxQ274pEN4pRNTSLX+i1mhKXmOCz36+Xvi
        AXHx3aOaH0vKheZ+up10Xo14guzyeg==
X-Google-Smtp-Source: APXvYqx2AF/0nei3cbfT7dFpG38kefGJKPj1T+ID4FehnxB+WWV5WCu3kFHfvnW+OlydcDvd+NXfDQ==
X-Received: by 2002:a5d:9f07:: with SMTP id q7mr12661134iot.21.1562766797210;
        Wed, 10 Jul 2019 06:53:17 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y20sm1655419ion.77.2019.07.10.06.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 06:53:16 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:53:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 2/4] dt-bindings: iio/adc: Add AUX2 channel idx for
 JZ4770 SoC ADC
Message-ID: <20190710135315.GA31393@bogus>
References: <20190623184732.5492-1-contact@artur-rojek.eu>
 <20190623184732.5492-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623184732.5492-2-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Jun 2019 20:47:30 +0200, Artur Rojek wrote:
> Introduce support for AUX2 channel found in ADC hardware present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
