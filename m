Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB95BF0D0B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKFD3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 22:29:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43754 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFD3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 22:29:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so7605843oie.10;
        Tue, 05 Nov 2019 19:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqC9TqSkya1o/KJL8zpucATnY1j4nIoBdkUAmUprxs0=;
        b=jrSsG8cKtzmLfjTWruSw+auCf9NPizBfqhQiIkhVgxCyhV9OT/SM2asnOTvnpu6dsw
         sIYd9ut8nrlO8f2VWuyo8H1uZHAwHKINb4pIhE6uD4WwXLVSUGlnSorvUVt7crlcwfYb
         uJnKGj4Us20r1KrU6fDJWFT93ibT3lo0HjWc8y660bFLe79CV7WNu2crUeHouX/9ziSl
         qcPywMz+N+LVyTA5PieXr7i1yzHEtPHGDCXi0W3OlDrH9+wPOgFfsNGuRLFT/vzX1cLK
         /0y+QRL0nGRaeCrdDLEhXd96OB1FNf2YAZsQpcXG4lD86DOs0MYPVu/8VZT67xmFw5iE
         q4BA==
X-Gm-Message-State: APjAAAWUTzz2vCjK/mujcDbmMPkoUNWhow7bxxALyhq1EGS28mTR3mMp
        nunX6DJ8l3IJsSpl0Lzoyw==
X-Google-Smtp-Source: APXvYqx/nF0CpBAElSmOBIYblIaOc2Wf6Sp7yrh2qYVI6M6XfnHyx1svrejcYxe9WS6YADmSZrE0LQ==
X-Received: by 2002:aca:49c7:: with SMTP id w190mr285191oia.117.1573010959021;
        Tue, 05 Nov 2019 19:29:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm3097164otp.59.2019.11.05.19.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:29:18 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:29:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add max clock rate
 property
Message-ID: <20191106032917.GA25856@bogus>
References: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
 <1572279108-25916-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572279108-25916-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 17:11:47 +0100, Fabrice Gasnier wrote:
> Add optional dt property to tune maximum desired analog clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
