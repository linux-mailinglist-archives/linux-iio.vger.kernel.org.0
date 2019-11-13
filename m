Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED558FB259
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMORR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 09:17:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39319 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMORQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 09:17:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id w24so1236177otk.6;
        Wed, 13 Nov 2019 06:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toakqbIkZVtaKq6Mw3W/gGKTFG42kt+BrKl60xyvmrE=;
        b=Q8l1W9TpIh4+UtoyG/zH0+IcMtwD14LT83smQ+8DLurfpKuwHI3PKdRu/thecg34Ay
         90ShC/0oJiu/wbjwXcE87wZcpAcvwO4Xeet4OSDZ2+Fftc9FB1KR+jJSGQ+jon26p7Wp
         S67tTfvDDf+C0U6SEiQxXh1O+Sa0HD7Hv5d/mTx2+yRQldTJ1lwOTYZWNgNFRk6PEiUF
         YUVo+wafVminBu+UYb50DfBog0JPrWyJxT+QSxSd68jmVkNA9C6P2lalyZaWY8wsk/8G
         IHXTquM8ApaVa/Vexd4CDyCsiuTBQ7UE1mec6QU2b6PpwVEBUGueZcCmeL4F+e1EFQUQ
         Q1xg==
X-Gm-Message-State: APjAAAV7N+13ABePkCtRijsu1OACh9wbfWEMSn+1QzrMh/nCjdpokrI0
        WjfARA2D+ay6A1IzUdk2Jw==
X-Google-Smtp-Source: APXvYqwhea1B4Xcb/+IpDdU+fV6asV05ixJSq3WT/O5IZyYGLoa/UYhfTB6zgkmSHb74r7heLlWWAQ==
X-Received: by 2002:a05:6830:1f4d:: with SMTP id u13mr3613004oth.77.1573654634483;
        Wed, 13 Nov 2019 06:17:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m5sm759357otm.53.2019.11.13.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:17:13 -0800 (PST)
Date:   Wed, 13 Nov 2019 08:17:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: add vendor prefix parallax
Message-ID: <20191113141712.GA9199@bogus>
References: <20191107130003.m6ul3klzmv2g2sbd@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107130003.m6ul3klzmv2g2sbd@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 07, 2019 at 02:00:05PM +0100, Andreas Klinger wrote:
> Add new vendor prefix parallax for newly created ping iio sensors.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
