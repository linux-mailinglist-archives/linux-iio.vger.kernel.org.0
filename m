Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDE35A136
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhDIOfx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:35:53 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:43740 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhDIOfv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:35:51 -0400
Received: by mail-oo1-f43.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so1380931ooa.10;
        Fri, 09 Apr 2021 07:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZBBOiFRpBx4bA8E/XQtp4Rp9qQp2tH4w680gLDV9MSQ=;
        b=VtrK5L1unl1CbOTPGmq2+MXqLgS9KwzU/eVDJAehA6Z8ctd0uT24VWE2ufQ2vWK755
         HNVortIuvk90ZW6i/JWhOn4rlBSuMAujWG3KYY4KfvZ+em/0JupzwrNcL3LuHVlmAcPD
         5vMhj85ZImzP26KjwXshkb6bSMcxc35eF9+M9+YBHt1kTrmVsdVh7c6vR0YVllG439N0
         QabN3W16IJJ5EvyOXPbF6UU1dRq4Sp/fizwTnkpTGPY3GfInGefiVTiA6QSctZ+qZPor
         qy6LNuxheLnqLrVaYkQjfEzut3d79budSaBT5FonK+6vN3lyLWf75kbj2IiDEAtgA8LS
         VgHw==
X-Gm-Message-State: AOAM532gX2Y+lz0xvujX0pI0ei0n7vouG7QLyJVWbFefl7zFw2HUrC0E
        fPx4Zvxdh/IY2bOi/Y627A==
X-Google-Smtp-Source: ABdhPJxozl9LMxtRqtih2nFFEiAm+HcRQ+a/UKgbt0l7xZOvpCJwyyc0PDYxzmPx/481UsLpBARMjg==
X-Received: by 2002:a4a:d24c:: with SMTP id e12mr12265114oos.73.1617978937516;
        Fri, 09 Apr 2021 07:35:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y10sm515544oih.37.2021.04.09.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:35:36 -0700 (PDT)
Received: (nullmailer pid 3612243 invoked by uid 1000);
        Fri, 09 Apr 2021 14:35:36 -0000
Date:   Fri, 9 Apr 2021 09:35:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings:trivial-devices: Add sensortek,stk8312
 and sensortek,s8ba50
Message-ID: <20210409143536.GA3612151@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-6-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 18:41:11 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Two simple devices. The stk8ba50 datasheet could be found via
> google, but I only have the driver for the 8312.
> 
> Given they both seem to be 3 axis devices with a single interrupt
> line, add them to trivial-devices.yaml
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
