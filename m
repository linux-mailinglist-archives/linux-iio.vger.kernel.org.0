Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E119830F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC3SLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 14:11:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45717 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgC3SLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 14:11:09 -0400
Received: by mail-il1-f194.google.com with SMTP id x16so16774750ilp.12;
        Mon, 30 Mar 2020 11:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s037sC2z9ESNjlnmzZ5RPd9h1faVevqStuCn9N98VOk=;
        b=hHSA4bdSUWu80EWc74x1j7IzJ/nIBJP7ZLwcbJ1G4kpzD6ONfztSUep6CsNXY85KIV
         GBV5vLkWwGeA7VGxORE634PvP644lrRQsQiOen+V4ZRXOCGChhJMGbr04OKMm8VfJiNE
         PY7hjRGg/A0EapvbDftOabiC0X1qKDtSccJweiPy2e6hqWLDJgrHdssALcEZivWUDKm/
         85h56Ict75N5wAXDMA+ZV6GynxvqHtpQMr4MHT52defgKGhkZSw6iVDruJ8+qvG0058A
         O3dugWu2McDD5n0HZ6CmrJqX0SE/+jspr74ojfA9jPKzAMB9lYTR4RH4XI/UcuvIWlFs
         z+iw==
X-Gm-Message-State: ANhLgQ16+I5XQqXEXVg/wLm1mo9z0NB/z9Gwyjt+3ZEZpZ5+b6cFCI5T
        87xPoTj4DXSv9tn4KW3eqw==
X-Google-Smtp-Source: ADFU+vvnW1E4loPKsXsXHGuRBP7ua4bfNufn3sVJlvuMFqQEmjNGX7i3bU6vAWNXSWc11oAu5L3yCA==
X-Received: by 2002:a92:88d0:: with SMTP id m77mr11696908ilh.282.1585591868568;
        Mon, 30 Mar 2020 11:11:08 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l70sm5158843ili.81.2020.03.30.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:11:07 -0700 (PDT)
Received: (nullmailer pid 8155 invoked by uid 1000);
        Mon, 30 Mar 2020 18:11:06 -0000
Date:   Mon, 30 Mar 2020 12:11:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: rockchip-saradc: add
 description for px30
Message-ID: <20200330181106.GA8102@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
 <20200313132926.10543-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313132926.10543-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 14:29:26 +0100, Johan Jonker wrote:
> The description below is already in use for px30.dtsi,
> but was somehow never added to a document, so add
> "rockchip,px30-saradc", "rockchip,rk3399-saradc"
> for saradc nodes on a px30 platform to rockchip-saradc.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
