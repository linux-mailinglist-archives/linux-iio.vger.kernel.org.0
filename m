Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A31A8E08
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440924AbgDNVuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 17:50:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37595 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440819AbgDNVuT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 17:50:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so1346921oto.4;
        Tue, 14 Apr 2020 14:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r6xzZ1b4JHWGtxEECvqX1ZeFiRv8Q65WRsOrzmnGvfQ=;
        b=pbJpBVaGtsjyamyR7k92/WWs2lcU0j2mDUF6sDJo12fDCEpi267bV4fX/0qnokVSiB
         EBLlEfm/DdYmMA2U2FgRDulbZWS4ITC0CbqL0hOGE1xPpGJJkOiFjUijqpxWKBa0NyC7
         i/Jo9yq+rVSEifohUO1Njb5/RJLFD22WuJpvvQs1jFZ/bjWOZxCM2+mVTzPYmmxTNluV
         6Z2iHFhPgWGoXqR3P4pTPG/y/UuqQGjyfvolooQZkWtLm2lkDgaz0cRqZd+PRERc2azR
         +B8+KeUB+UxQMiDaW0SvJ9+whzWn64DADT0Fg4OegnCd43u1247T9P6Ios+Gq2kYCkNr
         Fx2A==
X-Gm-Message-State: AGi0PuZRFxoc0gFxuUUZDjpxzhITaHSzAzQFUhDFZ4xLrwK1oupYrg0w
        erj9dyQSGWycQyS/N47QUQ==
X-Google-Smtp-Source: APiQypI4T5IhspzuZMGUVQLSFU+HW4jJmxEf4RMXRC/Ht0Wg9mRzSEMEd8lT6Oa91uUR9Pib4mx+KA==
X-Received: by 2002:a05:6830:1b64:: with SMTP id d4mr19628904ote.368.1586901018496;
        Tue, 14 Apr 2020 14:50:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm2576523ott.51.2020.04.14.14.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:50:17 -0700 (PDT)
Received: (nullmailer pid 22631 invoked by uid 1000);
        Tue, 14 Apr 2020 21:50:16 -0000
Date:   Tue, 14 Apr 2020 16:50:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: light: vcnl4000: Add
 proximity-near-level
Message-ID: <20200414215016.GA22563@bogus>
References: <cover.1586094535.git.agx@sigxcpu.org>
 <9bbbc30e5e8e67e50ddacb4cadc180fa5c7f7bd0.1586094535.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bbbc30e5e8e67e50ddacb4cadc180fa5c7f7bd0.1586094535.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Apr 2020 15:50:30 +0200, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> This value indicates when userspace should consider an object
> near to the sensor/device.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
