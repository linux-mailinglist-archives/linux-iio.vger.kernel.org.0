Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD146234F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Nov 2021 22:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhK2Vbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 16:31:37 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36713 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhK2V3h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 16:29:37 -0500
Received: by mail-oi1-f178.google.com with SMTP id t23so37157066oiw.3;
        Mon, 29 Nov 2021 13:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xCkc+edsnuz578j3nM7LxocCQHXE8TQPUnChXmN1Bfk=;
        b=AzpvJZWNOcCKykbQi1MGNuu0B1qkdsn2ALrU9P9qvOgW4ex25G6Hqd9VNLP/rW2iXF
         T272gsZISHGcy6Bs5WgfhZ+9HxkGpskGlpDVnm3D82c7Ria+HKVo+CH7As9px8MECMWq
         3x+sDFxQPdjYvpP4NwBU80tl/nIHYDneYKWeWWJFL48w2/XW8zVd1Grxyl6Syc9k7mOR
         JfDrnSB/R4odBEA7g12odFWYkWoz9Fqt3GI0VDc3BEbH116NV8YJhzRskCsnxfNDZY0v
         hnAXurk+F+pQk9YNBZ3GeqVLHE9XHhsTfhvemnXK+KpWvYBl50hNOMkMCkAdGh30cYXs
         VMgA==
X-Gm-Message-State: AOAM531CQCzC8L/qtpUuXJ+sT9AD+FYBIUw2mFK8NoAVosOwxcJfup9A
        3FSiDqmfO7M5oT9hGf/5GE2WxBK7wQ==
X-Google-Smtp-Source: ABdhPJxKZSsc0IJcsg3GjgSw0PgzgarXSf2BR/s4hyp+T38G0EdF0/6grP8nUqPDecJJnfdcItLSwg==
X-Received: by 2002:a54:4486:: with SMTP id v6mr561266oiv.90.1638221178764;
        Mon, 29 Nov 2021 13:26:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm2444712oot.30.2021.11.29.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:26:18 -0800 (PST)
Received: (nullmailer pid 637898 invoked by uid 1000);
        Mon, 29 Nov 2021 21:26:17 -0000
Date:   Mon, 29 Nov 2021 15:26:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH v2 2/2] Documentation: dt: iio: st_lsm6dsx: add
 disable-sensor-hub property
Message-ID: <YaVFeYsGYVOBS65b@robh.at.kernel.org>
References: <cover.1636816719.git.lorenzo@kernel.org>
 <54287a93922ac839501b776d288cc368aa81f0ab.1636816719.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54287a93922ac839501b776d288cc368aa81f0ab.1636816719.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Nov 2021 16:23:15 +0100, Lorenzo Bianconi wrote:
> Enable/disable internal i2c controller slave autoprobing at bootstrap.
> Disable sensor-hub is useful if i2c controller clock/data lines are
> connected through a pull-up with other chip lines (e.g. SDO/SA0).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
