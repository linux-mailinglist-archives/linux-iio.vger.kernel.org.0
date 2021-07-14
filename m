Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BF3C880D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhGNP6T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:58:19 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:35535 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNP6T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:58:19 -0400
Received: by mail-io1-f44.google.com with SMTP id d9so2721464ioo.2;
        Wed, 14 Jul 2021 08:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nxXW1i4WQyXMmsZCHbddFNUdKPkUyTw9t25kn4JLEw=;
        b=GDadw/UZJ4L/O7Kl8ads5gYhey1P2WR9Mabz0o+bd86cIqWGGomnaJbHKETlp8emdP
         qIPZEzr08HK59nvfiCnjPUrpqeDZy0L6I1CWsWl3VwY2LbOdepoc5ModqOvZZApUIjc6
         6sb7cJ2exGyKdyCLZWdl/wP0ZP5tMOummUTy60BH4nUucsEGd2c/VeeuYoCcRXUvnYX6
         BiOMxkk1edVbl3RYkz1Nr7hT9Mos5VXakFZ6Djhk2qQo+76sXBgISdL9iDf/Sxa4S7Jw
         r9Ggnc0RbnmeaQbQ6yaGitwsqncvSvfZvF+fRoKyFMjJMd3FQ2kaBJy1RKOUCnPNRixF
         pErQ==
X-Gm-Message-State: AOAM533n3LWGgIEE10NgYudjvt9ZrBbqagjPBP5kIiRgCOraktS0ykeo
        h75A3zL6GOiwEh2fjpfDug==
X-Google-Smtp-Source: ABdhPJwM2ZY8gTdRQCs9mZy1cHeRCXK11txvf4jNgPBZFJin9/wLLb8//5UvX8ZqjApegYngnzr9Bg==
X-Received: by 2002:a05:6638:3291:: with SMTP id f17mr9523408jav.143.1626278127488;
        Wed, 14 Jul 2021 08:55:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t24sm1439184ioh.24.2021.07.14.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:55:26 -0700 (PDT)
Received: (nullmailer pid 2648868 invoked by uid 1000);
        Wed, 14 Jul 2021 15:55:24 -0000
Date:   Wed, 14 Jul 2021 09:55:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 06/15] dt-bindings: iio: dac: ad5449: Add missing binding
 document.
Message-ID: <20210714155524.GA2648786@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-7-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:35 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Documenting existing binding, so little flexibility available.
> 2 channel devices that require separate reference voltages.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5449.yaml          | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
