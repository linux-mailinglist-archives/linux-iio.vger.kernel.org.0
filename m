Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A54327F9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhJRTyx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 15:54:53 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43832 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 15:54:53 -0400
Received: by mail-oi1-f175.google.com with SMTP id o4so1304740oia.10;
        Mon, 18 Oct 2021 12:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6I6Sfuna3OD0rMWi1ff5fM0/2M4IWqYf0vFWqx6Q+A=;
        b=7LrUi5rNaKDoHcJ36oRKf21N6iWE0o1yMQNyJDfyjdAabGtpb6PA2FBUg3TwB4ttdm
         s75jECfQPgvXaRSEo51rehCxtu2jVJmNguUdGs7xrmQVniXrqeKWbDbyiNBQqWf6yIAm
         oawpZDSIMCLZFlJ4Y8rRLerk+uusp8g0OOxDfwGaOUVP6zk7XeY1Z+cKmADV5UJZ3Rps
         UD52W7+6jFLY20zpls3Msc8ejpDynNOXZr/o9AlrCJIU2z8DKBz6g1mC2ebegWEeJewh
         HSBkoqGLvGt8rQojAE8NbDSlssTKjRd1kaTa1Fu2ONC6WyeUEKHpx8bFPFCcFnBHxciO
         3+4A==
X-Gm-Message-State: AOAM530rquAmIudYV0gtwt9zmkN4U8vZFB/UC9BbPa6huzfUiMr5CcsM
        yLJZ2HQXC5N79/9SeMQ1lw==
X-Google-Smtp-Source: ABdhPJwhFW+GuJ26cLhKeqsKsQ9+hwRrPd/sK03XOa1Y1uAJZ2hmaXpww4cKe5UJInqGIGsDKIrUkA==
X-Received: by 2002:aca:ba41:: with SMTP id k62mr720043oif.53.1634586761453;
        Mon, 18 Oct 2021 12:52:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g29sm3136078oic.27.2021.10.18.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:52:40 -0700 (PDT)
Received: (nullmailer pid 2842303 invoked by uid 1000);
        Mon, 18 Oct 2021 19:52:40 -0000
Date:   Mon, 18 Oct 2021 14:52:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org, peda@axentia.se
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property
 for settle time
Message-ID: <YW3QiAcIy2wdf3OP@robh.at.kernel.org>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007134641.13417-3-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 07 Oct 2021 15:46:40 +0200, Vincent Whitchurch wrote:
> Hardware may require some time for the muxed analog signals to settle
> after the muxing is changed.  Allow this time to be specified in the
> devicetree.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
