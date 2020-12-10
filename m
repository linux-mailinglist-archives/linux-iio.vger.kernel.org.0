Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208D52D5CBD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgLJOEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 09:04:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37953 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389824AbgLJOEG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 09:04:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id o25so5811857oie.5;
        Thu, 10 Dec 2020 06:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MLLm+mEEjeqlhPqYeqwFttUlHw74kkq347oncGq1Gw=;
        b=XOlKHm65DzjULTr5Z9/uMEPGvuhjLWdkGQqG6aGzELJwdPS8idPSYRSAcEztav6jXT
         ivLQw+Ah4QG/e5TKNwZl4yMkKqy0BPSxWyP45lLPKUGzgEy3NM4e9MMo15QTadJISmCq
         iBPt+AlSCasfcWroyinyKOsedhemYAwheXGDzzXXSVwbl1NLuZemXfGfDSyPnsQpkZfS
         2Ojiwol7HbpxnFvCvf1Kh39Xb0Lz2hWuHPqUI84T073gtSWrrEpipXvitfir+EC88YsT
         rRUQGSsTa4S6akUBTkhAj47Bh7K3olxy3ZJef++J/hRAmfBqP/eABIqcO3rPE93zHqWq
         3nIg==
X-Gm-Message-State: AOAM531EIQqzELhKw7qGGwZrXJqSE4qVI6TDk/eqWXB7V+0oyPQVklaI
        sw5HUApiSSEGEQTYRnaK2elvXfocxg==
X-Google-Smtp-Source: ABdhPJwG52D2wifZOqB6HTnMduClyCraQe186nghSc5IY6q8p1tskxYgGqkEMIu3RfTL+SAFDYXsYA==
X-Received: by 2002:aca:5e57:: with SMTP id s84mr5396974oib.102.1607609005231;
        Thu, 10 Dec 2020 06:03:25 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm264268oov.23.2020.12.10.06.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:03:24 -0800 (PST)
Received: (nullmailer pid 2425665 invoked by uid 1000);
        Thu, 10 Dec 2020 14:03:23 -0000
Date:   Thu, 10 Dec 2020 08:03:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201210140323.GA2425635@robh.at.kernel.org>
References: <20201208131957.34381-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208131957.34381-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 08 Dec 2020 15:19:55 +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  Changes in v3:
> 	- Fix errors
>  .../bindings/iio/dac/adi,ad5766.yaml          | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
