Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC08A1A37FD
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDIQ2H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 12:28:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45143 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgDIQ2H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 12:28:07 -0400
Received: by mail-io1-f67.google.com with SMTP id i19so125519ioh.12;
        Thu, 09 Apr 2020 09:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LkaY19j/MwuQxSFAk1XCaS+Ipv9wMJuPl6+2h930Pi8=;
        b=V+X+T4EMXci+LEgARr1orOrFc7TiRhDIgc1arUDbKqV3Oz92Cdd5YTNXJRTduaIHpm
         IT7HaJNd1T+1pD3EJ6aEFzVKMbNLiP/KkhQ0niCsUyW0mt2c0m9Iua/W8ndMJPkEFIA6
         oeEx/AzJDCuEX24lT+1JnXXdmzHHRF100d2pgPP4ZdJ0qcF3oSi2C+oXjVSTzRT09g+H
         QdttLh6GMJ1Kf7k+VsE0+XOqzLJpjb8ur1Q9cegmU5laz7XkZ6VX598gkhkb8IjXDMrL
         dUtZlZLU54auQwgzcIUeYh88sJZTICn+P4Wyn25Fl91QXQIFTlZZ1WRY6jG+8dySmxbi
         tY1w==
X-Gm-Message-State: AGi0Pua6nMkille0UiKHZGhrio7Cxtu+oR+9oQEDg8ONr6YbqH8GosH0
        j7XxzNhnF/r+9XWPJs0hDwjpAqQ=
X-Google-Smtp-Source: APiQypL6aLrtx6GwXLHD2x3wPcGDofdV2eGkjRpxhtk6rNI8MML2/IJMe7RHRqvZ7urbs0/hiih6Zw==
X-Received: by 2002:a02:9f91:: with SMTP id a17mr229200jam.65.1586449687298;
        Thu, 09 Apr 2020 09:28:07 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z2sm9271994ilp.21.2020.04.09.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:28:06 -0700 (PDT)
Received: (nullmailer pid 25790 invoked by uid 1000);
        Thu, 09 Apr 2020 16:28:05 -0000
Date:   Thu, 9 Apr 2020 10:28:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, alexandru.tachici@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: ad5770r: Add vendor to
 compatible string
Message-ID: <20200409162805.GA25723@bogus>
References: <20200327131825.23650-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327131825.23650-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 10:18:23 -0300, Fabio Estevam wrote:
> The compatible string in the example misses the vendor information.
> 
> Pass the "adi" vendor to fix it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
