Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1986419881A
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgC3XVS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 19:21:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43690 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgC3XVS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 19:21:18 -0400
Received: by mail-il1-f193.google.com with SMTP id g15so17625011ilj.10;
        Mon, 30 Mar 2020 16:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6CtYXa3sClSqnbvBiuHvvlUuxEGfNZdWolqywsT7lk=;
        b=F1kjGAdgCYgRzZnfNXO0634hDe2IOFAVhnf/XVqU6U6lcQZhxr4DDONwZj9D71qd2w
         ELvimVuy4QBSsxBp6TbKVGbB/uP7bHZEWXM5eWPIeSMlntXPQLqpG0UhaQfwNowwMHFH
         GfaqYgEXxdQkaWWDkYAjNi+1HggS49DGy80O5wEqPxTypILiLIIx7usNdKhqQisqpC8S
         BM57Jpk01XktEF8eiqmw1NOVJ01C6F9YSCZK+b4gIHvVgn/77mPEuynOAgdHm/EGgYii
         ka+0RPMpVHMB24YMCh7C5S0AQ0nq5ENH+kB/sOTx8f/HR3SphdWdOJ2F+ht+/AAm1Jpx
         L8Gg==
X-Gm-Message-State: ANhLgQ0Kd5+vS06rwazyhhIDoAUOlglxbZReuRWmPQ8d+2XrZZBE7Zn3
        cuGR9S9Aw1/QOB+yCTklzw==
X-Google-Smtp-Source: ADFU+vuaKs6BtYALVaqgUXUnIFTShETJESYag2YrRrycS+2I8mzQdSm2bGh9kir55sPT0pkBtVUhBA==
X-Received: by 2002:a05:6e02:be7:: with SMTP id d7mr14208948ilu.238.1585610477255;
        Mon, 30 Mar 2020 16:21:17 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t5sm3578511iom.3.2020.03.30.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:21:16 -0700 (PDT)
Received: (nullmailer pid 17537 invoked by uid 1000);
        Mon, 30 Mar 2020 23:21:15 -0000
Date:   Mon, 30 Mar 2020 17:21:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, fabrice.gasnier@st.com,
        olivier.moysan@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-adc: fix id relative path
Message-ID: <20200330232115.GA17380@bogus>
References: <1584641907-8228-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584641907-8228-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 19:18:27 +0100, Fabrice Gasnier wrote:
> Fix id relative path that shouldn't contain 'bindings', as pointed out
> when submitting st,stm32-dac bindings conversion to json-schema [1].
> [1] https://patchwork.ozlabs.org/patch/1257568/
> 
> Fixes: a8cf1723c4b7 ("dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
