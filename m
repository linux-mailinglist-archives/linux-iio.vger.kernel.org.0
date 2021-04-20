Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130B366076
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 21:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhDTT43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 15:56:29 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35736 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTT42 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Apr 2021 15:56:28 -0400
Received: by mail-oi1-f180.google.com with SMTP id e25so10189553oii.2;
        Tue, 20 Apr 2021 12:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMh97YRuNmw/TbWDb8SdRQd57mPm4TQGME+PoltBDTA=;
        b=nSnP3nk4bmpO6QcGmUUmiCMHhSqp8y5d2Fo8ZQyZMhzIaFRUhuV8cPRXzQjXTCKPXf
         1w520AVBAZQH7Y1c+Jqt/iaGqH5jvDnLOuCjMQY5HJ0BKeCYLip0rw4rquIhTjcXVtwE
         BtBwLsetMwjWeZKJYTbSK0MuoBHVKCb/fAfywuyLHlxgutCB0XWk3UI+VZA00zZkQiHn
         OhChQVClOKgvu+FTPtzFf+TCYH6ydS8SdfCNpnOh8NPDRkKCSy92cJaRg9QSxj+/m9WM
         G/+9Z1BYkov40FxgoKIdqUuO3YxLLEEMJymcyx/q4m1X8kyxZzzRL62bjF40ukG/FsqO
         +fBA==
X-Gm-Message-State: AOAM533Ayei0zSEJuvZEvnLVdTonGNwbrOtxrPpRxbMDlKh0y8REuDfm
        62/k6YUHUO+nph4/1oVcIg==
X-Google-Smtp-Source: ABdhPJw7OgN4E3pDW9L6Ft6wIP5WTyF0EGcPdva0ZRMpd3Pb/ClBSOS63LIFEiar0lTmYCHP27Oaiw==
X-Received: by 2002:aca:f30b:: with SMTP id r11mr4345215oih.133.1618948555310;
        Tue, 20 Apr 2021 12:55:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q10sm10826ooo.34.2021.04.20.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:55:54 -0700 (PDT)
Received: (nullmailer pid 3710736 invoked by uid 1000);
        Tue, 20 Apr 2021 19:55:53 -0000
Date:   Tue, 20 Apr 2021 14:55:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        =?iso-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 7/7] dt-bindings: iio: st,st-sensors: Add LSM9DS0
 compatible string
Message-ID: <20210420195553.GA3710659@robh.at.kernel.org>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
 <20210414195454.84183-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414195454.84183-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Apr 2021 22:54:54 +0300, Andy Shevchenko wrote:
> Enumerate LSM9DS0 (accelerometer and magnetometer parts) via
> 'st,lsm9ds0-imu' compatible string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
