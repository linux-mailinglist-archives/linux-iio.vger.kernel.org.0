Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD36397D27
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 01:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhFAXrh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 19:47:37 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34342 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhFAXrg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 19:47:36 -0400
Received: by mail-ot1-f51.google.com with SMTP id h19-20020a9d6f930000b02903c0c4560e99so936835otq.1;
        Tue, 01 Jun 2021 16:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28Cx6oh2XIQQKFZY2k+wbbIN9n0uRkJwk+EZKm9p+8g=;
        b=exdP/wSqO/Uhepa9Fd9gKVFDiW/IA3VmnPKsfXFe5Db6ipgFCYUOvFrtNqOLAmEKWs
         0z3+xA+7UuZfY+6jWa1wiGLN3bBuzPoAd0LmSeBFs8jhjs/ChJVHIbRrpsr/fAMcH66c
         8KqpQZYe2fhlx5lr13ho8h7HFFib/41XAeqxwMpy4RsQVzafXQvcBeEcQ1Utd5UfjCDT
         DfM8VZyGpetRmxcI3UrRFxeGYd0nRH58kmU9Famz9UlYeeJ7vwh/NXYnaxLyJoTVaKr5
         RfQXNis44Mm5XbylXiIDc9vV2GbE0Q6xX46cC/MqAtWLNMlo4qEscUGCNgcw5+gblnzM
         A7lw==
X-Gm-Message-State: AOAM532pM9o7/o+v0VW6xQj2K2EUwNy29p6pWBmiFvoKlrvsTtui0Byx
        xhSBrAyGMkqeZe+OwwgOsg==
X-Google-Smtp-Source: ABdhPJxjjjUFGsav+J/kngpPdRLMbXsBhctsJGp3XDoMwei3shpp3w8TDsQZ7irz8WsSFz/WhFL+1Q==
X-Received: by 2002:a9d:61d6:: with SMTP id h22mr24183149otk.149.1622591153137;
        Tue, 01 Jun 2021 16:45:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m189sm3682230oif.45.2021.06.01.16.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:45:52 -0700 (PDT)
Received: (nullmailer pid 1350962 invoked by uid 1000);
        Tue, 01 Jun 2021 23:45:51 -0000
Date:   Tue, 1 Jun 2021 18:45:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: iio: multiplexer: Convert
 io-channel-mux bindings to DT schema
Message-ID: <20210601234551.GA1350488@robh.at.kernel.org>
References: <20210522112908.1611389-1-jic23@kernel.org>
 <20210522112908.1611389-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522112908.1611389-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 May 2021 12:29:08 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight conversion of the txt file using the mux-consumer.yaml
> binding now that is available.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../iio/multiplexer/io-channel-mux.txt        | 39 ----------
>  .../iio/multiplexer/io-channel-mux.yaml       | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 72 insertions(+), 40 deletions(-)
> 

Applied, thanks!
