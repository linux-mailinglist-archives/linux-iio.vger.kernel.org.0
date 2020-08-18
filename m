Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE80247C36
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRCcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:32:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40942 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRCb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:31:59 -0400
Received: by mail-io1-f67.google.com with SMTP id b17so19692574ion.7;
        Mon, 17 Aug 2020 19:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9DIjN24akfAga2JnIpgG/weuVy5Kca20Q1RYtb94+o=;
        b=I6tPDYhnqiVqcR4V0as+EFlnFUn334VCmFcNn5MckH0UZsIlAW6sTyjYvqKkrJOdf1
         7CWVetpCj7KGZx5+z5FMDn6qC8AzAV6UoXxLhkBSYArTkinSYnuRf0X3pWXC2OiXHRgD
         uxAwvfbZ2+cy4/fVuKbOgYUxfGU0OCFxno/WeRABvbhfkQP6mtHpTtv9P7t+VaarHVhf
         ylSpCtvMXE/tnGxlQ6U/IIIRY3tdgzyLT43DL1dBs44n/omrR4e5OUYCaeKWJPVj8oc5
         /LhnjGeuzOwMQiDw9Tmex7HAA7/o0mbTRnGBxwDiB3ypalMI7qAUWTKqXJrJ0w3lehUu
         KHIg==
X-Gm-Message-State: AOAM532SPJaRXyfp61gU2y9sCn5mo+XAOeukQXWv+LYUXNz7X0/p/dCA
        OQc+uE160sE5L8QG5hZT/NAthzdVTA==
X-Google-Smtp-Source: ABdhPJzIYq1JISEfzto9o8eEEH5ulv2QwxWiOmoidazOfbwbJK97QlmXvSwBIMc5OAx7VHmwhupLJg==
X-Received: by 2002:a05:6602:25c9:: with SMTP id d9mr14468808iop.150.1597717918376;
        Mon, 17 Aug 2020 19:31:58 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p20sm10255237iod.27.2020.08.17.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:31:57 -0700 (PDT)
Received: (nullmailer pid 2174936 invoked by uid 1000);
        Tue, 18 Aug 2020 02:31:56 -0000
Date:   Mon, 17 Aug 2020 20:31:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: iio: adc: ti,ads8344 yaml conversion
Message-ID: <20200818023156.GA2174856@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-12-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:51 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding so easy to convert.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/adc/ti,ads8344.yaml          | 51 +++++++++++++++++++
>  .../bindings/iio/adc/ti-ads8344.txt           | 19 -------
>  2 files changed, 51 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
