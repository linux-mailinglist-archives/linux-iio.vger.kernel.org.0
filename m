Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD221A983
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGIVFq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 17:05:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33952 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIVFq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 17:05:46 -0400
Received: by mail-io1-f65.google.com with SMTP id q74so3859762iod.1;
        Thu, 09 Jul 2020 14:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciOCqx+pAUOAXkMzh0J3FjQTCHj6Fd5iCNLqebgsDgU=;
        b=Gvs2fV2bO6x3CB44xl1nvtx1nl2LTaIM1Lr7ntZTq+sQvhXcpVkciL6gGuCYKFt8Bl
         sj3+AaZG1UqKAmq6B9EL8nuiITAi3j/3/hox47hjMPyZz1zeZz0mr6cI9RfdRJhC5J7+
         SKPl/7FF6EczzqtI8O8ZcMiu7Yg3ya1gcSZFwm2MaAKcVMM0A9pwSQY9x4PJox9nQgTk
         bBkxcKR27LykZPc6+W3q0HYvY3pEjuL3SVT2Aq1X41va4bynouu7ptO8PlOl+/12JK03
         z+4fIq4bEk9EsrCEsyFWOSHttocuB0Y9zIehgM36PmdztWLPy3IPSfLsCGgeliFcB2ej
         nE2A==
X-Gm-Message-State: AOAM531NroD/mlpesDpPZRg7eLDxnt4iKxs9W52UYziu/zL3tu7pjHUL
        ydIYIzD+w0eBq8Ow5aGp9g==
X-Google-Smtp-Source: ABdhPJxnuXjSuIY5ztk9nt9DROEKLr7d42biy9Xnb6UFa5gqju6Td/lGBeURmolKL3CIcMJNVa6suA==
X-Received: by 2002:a05:6638:dcf:: with SMTP id m15mr75131676jaj.86.1594328745143;
        Thu, 09 Jul 2020 14:05:45 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v5sm2709848ios.54.2020.07.09.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:05:44 -0700 (PDT)
Received: (nullmailer pid 884608 invoked by uid 1000);
        Thu, 09 Jul 2020 21:05:43 -0000
Date:   Thu, 9 Jul 2020 15:05:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-iio@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: microchip: atmel, at91rm9200-tcb:
 add sama5d2 compatible
Message-ID: <20200709210543.GA884561@bogus>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
 <20200706114347.174452-4-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706114347.174452-4-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 06 Jul 2020 13:43:45 +0200, Kamel Bouhara wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
> Instead of being MCK / 2, it is the TCB GCLK.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 42 +++++++++++++++----
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
