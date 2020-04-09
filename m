Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A101A3C59
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDIWVT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 18:21:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46664 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIWVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 18:21:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id x2so1743384plv.13;
        Thu, 09 Apr 2020 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/z7pZVsoL64ZtHgrjrIO469h05laKsMY8CKKpD5QBo=;
        b=QDOj8D/0r9lj0VWPS1hjZHjen3FyvjOFLPFuK0iOffJfzv068Gx/QiT2kIHxjKOQ0z
         lkqACCkh60DlDPaXdimT+TKHWH+MqoBZ0NUwECdtXy6k9D3ZYZoXaETRK3Eq54wZTOVz
         c++xc1HVAERJnZJ7mvOPzBGs701RvlpqK4t1YivkmIwgDtJpJK4uNhn8+Z54FdggBaxd
         AkmXvXalebDcPhqo16yBlTde3FlwHy5NQox9i0zOy5cqGmJYVvn68E/1zaxZkyKKTtCi
         CStml2P/48l8YMIkJZneReGDGcSek3CTQx9VV8aM9dfXeI/a8wbwUCgBJ+nW9BSpzIYx
         wxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/z7pZVsoL64ZtHgrjrIO469h05laKsMY8CKKpD5QBo=;
        b=S8HpXIR0dzNfuGgFDvLUbeS83HEKUHDM9Lc+yYQHBZfdFWVkG/oeCsPhAExpGSMprv
         D4fu1AN6fGk+89Gqq3yPRnfhSl6B9fVsjh5akJfxZ4eMQXK99+yTudEi5hd3BKW0k0VW
         Evx+4SHBRPrkAUvZ9zemPWMqSQl8BcXsRUzcE7lJHHv7ghMbRctVodrclonqlV02YobM
         U7NWtPBO4gdksHMuM2jRjfQeCl8ji7c3uC33z6R14p2hV4AljYhaYvHG9J5+fVJDllm+
         4DRtqhkC11deMN7TrDexIJYXGtml3W4m+tmFBa3UhwSsup33RlMVgWFIjt5c+q4r//xB
         /nTw==
X-Gm-Message-State: AGi0PuYoXQ+IqJrEPcXojDAaZKFk53tMU/zKu1vy3yTZXgvruxT8XwAf
        U3ExWe3lmr8b2TX2GFs4oOo=
X-Google-Smtp-Source: APiQypJeMlNd4RzEjBh0f9WL+l4grp3ZuAocSpUJXgM81FgeIXhiv5N3Q2EbBQtnxVdDVkNUIuKe1A==
X-Received: by 2002:a17:90a:c08c:: with SMTP id o12mr1862986pjs.16.1586470878413;
        Thu, 09 Apr 2020 15:21:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id q7sm94017pfc.166.2020.04.09.15.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:21:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:21:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Message-ID: <20200409222115.GT75430@dtor-ws>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 06, 2020 at 05:58:05PM +0200, Kamel Bouhara wrote:
> Add dt binding for the counter variant of the rotary encoder driver.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> new file mode 100644
> index 000000000000..a59f7c1faf0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rotary Encoder Counter
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +
> +description:
> +  Registers a Rotary encoder connected through a counter device.
> +
> +properties:
> +  compatible:
> +    const: rotary-encoder-counter

I wonder if a separate driver is really needed. The original driver be
taught to use counter device when available?

> +
> +  counter:
> +    description: Phandle for the counter device providing rotary position.
> +
> +  linux-axis:
> +    description: The input subsystem axis to map to this rotary encoder.
> +    type: boolean
> +
> +  qdec-mode:
> +    description: |
> +      Quadrature decoder function to set in the counter device.
> +      3: x1-PHA
> +      4: x1-PHB
> +      5: x2-PHA
> +      6: x2-PHB
> +      7: x4-PHA and PHB

Is it really property of the rotary encoder itself or property of the
counter device?

> +
> +  steps:
> +    description: Number of steps in a full turnaround of the encoder.
> +      Only relevant for absolute axis. Defaults to 24 which is a typical
> +      value for such devices.
> +
> +  relative-axis:
> +    description: Register a relative axis rather than an absolute one.
> +    type: boolean
> +
> +  rollover:
> +    description: Automatic rollover when the rotary value becomes greater
> +      than the specified steps or smaller than 0. For absolute axis only.
> +    type: boolean
> +
> +  poll-interval:
> +    description: Poll interval at which the position is read from the counter
> +      device (default 500ms).

Is there a way found counters to signal an interrupt?

Thanks.

-- 
Dmitry
