Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2D250EFA
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 04:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHYC0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 22:26:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44619 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgHYC0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 22:26:18 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so10914787iow.11;
        Mon, 24 Aug 2020 19:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1GQRlcSM3ouksguMtbD8EEmhZt6aa4eeV/aBcNTK0LA=;
        b=Ukk3QWusmElkECMUOGIm4FWxCDDv9KCi6k2GKXM3KgqSC3nxA/Ah1JLxRREe75+NAc
         +6fn+YrwArWKX4MVOGrgSsheYu5+Im55vrPAS4FGEAm96SkNIxXrLu4DKH8P2WArQqSk
         1JU3xub2ALNyetHwC0QwOjSneZGuoO1bQoFycWXfY2rhzlBUf6clTm1kH7eJSk0l695M
         W957+jGJL2ms+YwnAzxYSAT9dlJ855SUVFoI8G1zJajE/lZhQzD2ICbVLMfpPV40NzI1
         HrMHRyp90UwQxoQ+JEs/ZCwEaStSbGgnfDYLGBiDaK5txTxL6BCmXb2FgyL27ppQO67P
         XJ4Q==
X-Gm-Message-State: AOAM533Z2ScGtCpsJfTSAQokxgJ3yhArUEu7Bg8HVBf+5JOqT2dYDhuM
        3MIfLWfBeQvkp7JEfvaC36c0jALLtnJT
X-Google-Smtp-Source: ABdhPJzIoKI3OnWT62TiuzDaKocAUDfh3R5Kg4yB/rhMt0RNDIXpgPGz0OpkB2hty0328RlUAU/DCg==
X-Received: by 2002:a5d:88da:: with SMTP id i26mr7236318iol.158.1598322377965;
        Mon, 24 Aug 2020 19:26:17 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f6sm7625559ioo.32.2020.08.24.19.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:26:17 -0700 (PDT)
Received: (nullmailer pid 3816723 invoked by uid 1000);
        Tue, 25 Aug 2020 02:26:15 -0000
Date:   Mon, 24 Aug 2020 20:26:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: chemical: add Atlas EZO
 Humidity module documentation
Message-ID: <20200825022615.GA3816694@bogus>
References: <20200817005052.11565-1-matt.ranostay@konsulko.com>
 <20200817005052.11565-2-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817005052.11565-2-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 03:50:51 +0300, Matt Ranostay wrote:
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
