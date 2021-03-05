Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D432F591
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 22:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEVx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 16:53:27 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45401 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEVxC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 16:53:02 -0500
Received: by mail-ot1-f44.google.com with SMTP id d9so3223329ote.12;
        Fri, 05 Mar 2021 13:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jn+AajaNbfjpE+EdYoocgU+vKOOBs2yjBbfpHaZv1GI=;
        b=ThMLxCcCDD0hVbfTcJocl6CWm9Yv1ZuNDx4q6QdSfBxKj98Yckxw/rD3u5bJN6hCmM
         Gch5czzOhf2S63WGy6yNF9i7nWhB4oEVeERalG6WE0Q+Ezsc3wQM7utP3jLQNMrB1Ouh
         0nREav1jikQ0XjUhJEk2guENv86/oBs5Qe3MGt5UrDn164aCWB4SY5ApzykvD/N5KUDs
         gBhl4aEAipo6m8qdntkfVuRtku+yEHLqMP+O1fe8v68D43dTTVNAlun+lXWO/Q+Ppb50
         zNR7j8JP0NxnptHoRPXsUiCvZukzozyqE4ba/zldONXIVB2jbSB8cDKrKtitGjZWtA5i
         OYww==
X-Gm-Message-State: AOAM533O5sMcl6XZyXjCtubn5HyX8t+xj/L6QkSNQnlm6Ntq3w7dPuy0
        MY3YUxMZbiys7QU86q21OA==
X-Google-Smtp-Source: ABdhPJyVWbRJ7vjT4J4BI8+tUAFBur3ManytqggzN1Uj34RLt82zGv8MFaSZk78Kn7efZBksEJ/LIQ==
X-Received: by 2002:a9d:370:: with SMTP id 103mr261110otv.232.1614981181534;
        Fri, 05 Mar 2021 13:53:01 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l71sm811602oib.30.2021.03.05.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:53:01 -0800 (PST)
Received: (nullmailer pid 710456 invoked by uid 1000);
        Fri, 05 Mar 2021 21:53:00 -0000
Date:   Fri, 5 Mar 2021 15:53:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v6 1/2] dt-bindings: counter: add event-counter binding
Message-ID: <20210305215300.GA710408@robh.at.kernel.org>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
 <20210216081356.3577-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216081356.3577-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 09:13:55 +0100, Oleksij Rempel wrote:
> Add binding for the event counter node
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/counter/interrupt-counter.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
