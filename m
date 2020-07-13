Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ECF21E06E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGMTFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 15:05:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46095 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMTFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 15:05:45 -0400
Received: by mail-il1-f193.google.com with SMTP id p15so4531258ilh.13;
        Mon, 13 Jul 2020 12:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrvcQ3XXk1KzrgC6nT6teiKkOx2wvAzWo3+7umnWakI=;
        b=Ezjx3XcsktzLE4tXb/dpKq8DtswUPJY5SBdG4LKQPHMdXvasLnddjw2SgNSq3ePfIq
         UHDJLvtFxwsSHV0wK2HWD4KPpBzw1Bp0T7INIuCRV+ukWodcZkQ7brgH9S/hU+SzIaCh
         wRcFYfH4lN5ou1covnr7ivzQ3YWUvTWy4z4BsvGGEEEARxCYTmgqaBeTF5orvieELpuo
         48CU3vKHs06SmBo+cseO8+smkrKPZCeDVrjPzM9Nni6it0O/pyMvmiRqObGFw/BKpmE9
         VyCtzOkbp5jTB4+LecOGW50zE6y2OpdC2X9RpRSWVP2ROxvb0wRBXMgeIYv54aIIWz/Y
         1ofw==
X-Gm-Message-State: AOAM531hWL2LjH4+8uVq6hY0HoNW0mSeYI5gsv4/kgfiHhehpuoPmrsI
        9FJ08ViVmWhYSof0fuJ9+Q==
X-Google-Smtp-Source: ABdhPJzI5P2l/De91UCc2ApLOJll02gpiZ1KuuMFwDXuiZHOiQC9FRAd9TMA2QCnxrkIHZs5vlNOqA==
X-Received: by 2002:a92:bb0b:: with SMTP id w11mr1278077ili.238.1594667144105;
        Mon, 13 Jul 2020 12:05:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c9sm8627870ilm.57.2020.07.13.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:05:43 -0700 (PDT)
Received: (nullmailer pid 551183 invoked by uid 1000);
        Mon, 13 Jul 2020 19:05:42 -0000
Date:   Mon, 13 Jul 2020 13:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: bmc150_magn: Document and fix
 missing compatibles
Message-ID: <20200713190542.GA551135@bogus>
References: <20200629100537.20365-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629100537.20365-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jun 2020 12:05:36 +0200, Krzysztof Kozlowski wrote:
> The driver supports also BMC156B and BMM150B.  Add existing compatibles
> marking the BMM150B one as deprecated (due to redundant suffix "_magn"
> because the device unlike two others is a magnetometer only).  Introduce
> a new, proper compatible for the deprecated one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Add compatible only for bmm150.
> 
> Changes since v1:
> 1. Mark old compatibles as deprecated, add new one.
> ---
>  .../devicetree/bindings/iio/magnetometer/bmc150_magn.txt    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
