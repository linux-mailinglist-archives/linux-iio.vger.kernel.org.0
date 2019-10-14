Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC906D663D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfJNPi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 11:38:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36080 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfJNPi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 11:38:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id 67so14165459oto.3;
        Mon, 14 Oct 2019 08:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwtrF8vu7chX76FV9/GxFNXjc0TLtsx67LOkLYSDyzw=;
        b=DfCoxNrd9LIc1NJ1nzu6BTNsg1yYqPIvGhUi4aeueES2tiFOtWVOfNqy5/P6E3swhC
         4u7Q43/pMhNBYcVF67zbyloc61mGGkXfKgP1j6QTEKSvDCP2uBPadOyo5vq7RUxLjywj
         mjMMlvWfCh/sepixE7dRYCbYm140Kq9UiuiOXiopZMKcaqfGD53Xi3bhzD5J31oRv2KQ
         OHONcZQk2O5H6Iy4QHJfclODHxNU2cmyNkuB/5vgw4YKfIJb6GmLwSGzCbKhIetBNzS8
         cvHt22qe49wR46ze8J5NZlXvFrUDI0LizlMVdzTcmkpvgMqbe56gLhRcWpZN0GYT1KGf
         /t4A==
X-Gm-Message-State: APjAAAWrdN4SvI5Axtak1wI6jt3ANT07IReVB4dycGAgxxEdKZvrnO2g
        FxJjFQwIb1KWkEmj/LzjgA==
X-Google-Smtp-Source: APXvYqwAwneQ4dzgNflP8bLhQd+6oDoO8iCbokU2yrniDjJBK3cefSOZaeyAn1g3qtVUzF2jPE7xVw==
X-Received: by 2002:a9d:5e12:: with SMTP id d18mr25324093oti.220.1571067534410;
        Mon, 14 Oct 2019 08:38:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm5400237otn.44.2019.10.14.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:38:53 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:38:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 8/8] dt-bindings: Add max12xx SPI ADC series as
 trivial devices
Message-ID: <20191014153853.GA26878@bogus>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
 <20191011144347.19146-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011144347.19146-9-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:47 +0200, Miquel Raynal wrote:
> Update the compatible list with three Maxim ADCs compatibles.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
