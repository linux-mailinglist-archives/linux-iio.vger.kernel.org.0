Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD193314F9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHRgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 12:36:54 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:38177 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHRgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 12:36:38 -0500
Received: by mail-io1-f44.google.com with SMTP id k2so10825584ioh.5;
        Mon, 08 Mar 2021 09:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLB0D0dqPvkoBlx5FQY0xeyklbdt3EEHqBKOHhd3QkA=;
        b=GH/7BW2FGpZW6GeYf+2TK1+FvQDIlmFgFpU6U20FlB6kfZ6RmBBddd7RC1+zPUAbxS
         XOWQ1YvS3LPaMp3xnPTPWH1e4iK5AmtUVb6MowMYd1TfAhhtOEX1iQW4nHYIJv+8KHFM
         6rs+Yy7XVZOAKAuQmGVPzQ6PQNR/ErezM21NPgWDgIHZmJ9U5wu/6HeADlRV9nwlov5x
         QLNjUJKd2ayYcQqU/JUHj3qysl80MJuLgR/VO624vN0kFjr1r1HMdcwqOFhfsUMYc8zJ
         3BmTMy1VBtjwcVvcpXHwtcj0BXsn1ulPjH3DVJxeDYySa1V1JIpzjU8P7ofI0QbVDDId
         IDEQ==
X-Gm-Message-State: AOAM532BJPJwG9erYT8XeZINLjdjintbZbRncmSB2D9hlBaAFWOBJvgi
        Rzx84cqktns0K7H0qn6U0WR9YqWzzQ==
X-Google-Smtp-Source: ABdhPJwZUlyWYrGbpy+LLbYM+uQLi47XtxdQFWoUcUwQ18c5Y1jfvZzKDszpkZckfM/Ko4qO4Sw18w==
X-Received: by 2002:a02:6014:: with SMTP id i20mr24053865jac.101.1615224997590;
        Mon, 08 Mar 2021 09:36:37 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 11sm6265668ilq.88.2021.03.08.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:36:36 -0800 (PST)
Received: (nullmailer pid 2675515 invoked by uid 1000);
        Mon, 08 Mar 2021 17:36:34 -0000
Date:   Mon, 8 Mar 2021 10:36:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
        ludovic.desroches@microchip.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: at91-sama5d2: add compatible
 for sama7g5-adc
Message-ID: <20210308173634.GA2675469@robh.at.kernel.org>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
 <20210301143256.16502-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301143256.16502-2-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 01 Mar 2021 16:32:53 +0200, Eugen Hristev wrote:
> Add compatible for microchip,sama7g5-adc device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
