Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32D1C5C4B
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgEEPqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 11:46:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42429 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgEEPqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 11:46:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id m18so2011090otq.9;
        Tue, 05 May 2020 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pC5ug4JkZ/Q1WpOKLw3JKlztM2npyZ3pEia8DpeRqCM=;
        b=I63xafTwMnX4W9jxGF1o8zUIhO9qhDw/Ksb0PVNgkxjuYXKccTSExtvsEbRCVyjlR/
         NPvBR/2PC3kOy0i//tyMkUxlDtve17oUjyXEz+TIo7S9ZzdxcAXBJWzUy0l1Ae4T+jFf
         0PvdKkoGdLO7BlHyvZUCzXxBCipHUXfKkuZwv+CnJkZ5NQGLlYZqxsYn3NkIwM83hufP
         1IFkS6UrtQIFtHEc4IqFP4fRWGEAia6jMDkO2U56MywTNwjHVvMk74P71q+qQgt1c71p
         j58hPSk82hk3zAoyc83P7KRNDG6OFifa7NmqnMtOvlxKFd7NzoMJPvvz7uL9ab/9wP2g
         iSFA==
X-Gm-Message-State: AGi0Pua9ff4L6vqMa+l5/zs9kL4jSxBlXuUraBVyCC8/RWk8ElY0VQbE
        m89qzuevykB0u+ZU8wJ+4g==
X-Google-Smtp-Source: APiQypK8wD7ubhAL2Dzd24hZqNu9gr5fEROybj1HrCSj0giazCxA5YvV8rF/q4mgDhvkKDnmlBl5lA==
X-Received: by 2002:a05:6830:1d62:: with SMTP id l2mr3132718oti.316.1588693569153;
        Tue, 05 May 2020 08:46:09 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a93sm694156otc.12.2020.05.05.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:46:08 -0700 (PDT)
Received: (nullmailer pid 12692 invoked by uid 1000);
        Tue, 05 May 2020 15:46:07 -0000
Date:   Tue, 5 May 2020 10:46:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v11 1/6] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200505154607.GA12636@bogus>
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430155810.21383-2-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 17:58:05 +0200, Saravanan Sekar wrote:
> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
