Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E586D19830C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgC3SLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 14:11:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46943 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgC3SLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 14:11:01 -0400
Received: by mail-io1-f67.google.com with SMTP id i3so9652440ioo.13;
        Mon, 30 Mar 2020 11:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOO15GTd6VMJnM7Vi9uKnAyHVwmUw9igV5K6wV5i/qM=;
        b=gunoO2FC5zQexEocus1HHnmhGuiDv0E3nl5x6SxJDKGqTA+Mm9O837OdtJz6WfLdbd
         AuUbosBoE9NRrLdsJXa5OiwnjVp7Ak35BB2ncAE5hLsjl75ptQpnrOO4wTmr9QJiiwWM
         +5N2eDbSdLWeeSvRvPwsxaPXGechiwU6gH+j24UFRdUidz/ZZ8PLVt4gspJrLylaC3It
         r+IsEYSgzmr6ZCa50jsZA7u/ngevFvL8ti/QHmMdUdGTLkjXCmekCS+5jkC7M3HBax00
         y7/0lIqJnNM8xE9PKaxTbI28BP4gHRgchWTMGm8h7ulZi2b9H9Z0v9xiV1JQzD+M8jlw
         NIUg==
X-Gm-Message-State: ANhLgQ060MMaPUXgIT7j1mTqLhEajZqF19nsYR6k3H/ZssYAzlSKJ9Uu
        7L0K9xKwgkUOlNoXPOS1+A==
X-Google-Smtp-Source: ADFU+vszv7QlWuGRxLn/4cSSGQjs9iWOqFzPmappatpYrI4PCTkw+D3ItLDJOwk+AgCrktkz1XvRNQ==
X-Received: by 2002:a6b:8f11:: with SMTP id r17mr11057330iod.92.1585591860508;
        Mon, 30 Mar 2020 11:11:00 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d19sm4316256iob.30.2020.03.30.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:10:59 -0700 (PDT)
Received: (nullmailer pid 7866 invoked by uid 1000);
        Mon, 30 Mar 2020 18:10:58 -0000
Date:   Mon, 30 Mar 2020 12:10:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: rockchip-saradc: add
 description for rk3308
Message-ID: <20200330181058.GA7814@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
 <20200313132926.10543-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313132926.10543-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 14:29:25 +0100, Johan Jonker wrote:
> The description below is already in use for rk3308.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3308-saradc", "rockchip,rk3399-saradc"
> for saradc nodes on a rk3308 platform to rockchip-saradc.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
