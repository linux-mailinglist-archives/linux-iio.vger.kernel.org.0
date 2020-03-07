Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF84B17CFE0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 20:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCGT4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 14:56:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35440 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgCGT4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 14:56:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id u68so2149193pfb.2;
        Sat, 07 Mar 2020 11:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIPv+608Penp2tqrBoiqSOfM0ifqfs6R5psZoy4V//E=;
        b=SdZpO34B7fMOo0MeedTBPL42+dbcEEiRU8gKF2znmQzlazHsJCGMO8birNtiHQRqXl
         5C4ggbok4KcpSwST2LHtd6w55+78Zy2NWJOOU5sNzHzdhrgcActFVGsRnc7vadb/wT/+
         fshYdpwTHFcq4SSoSrDVddgQ3Zd+szbPYGfIbS08vmUilZWFZzFMqtEZEyNsxGYAPG6o
         FP8LYVFilSYH/xFo+o0wR1DIeWXjKZMYFjyAsI/s4GvpTxThJ+GmT6DwSA6QXg+i/rKM
         xvgf3p04MBcc8AYaSwv5bLNi7gN7IMGAyvWiqRih9QCbgz74TW6077UBqUcAVOWj9QZv
         vqMg==
X-Gm-Message-State: ANhLgQ1rJiWJZhe1Wuz53Ykq3ESu0RQHMXLJDlj619nIx9cS9UKPm1lE
        kMFeBJ3iBI8tNXtoSa1tzdY=
X-Google-Smtp-Source: ADFU+vvdXyX/KFWOVfWwXMtoxHR9PLVMxaIgUwkUoA9H/h231JgEDcAyPn/RRopLUiXpp2tt73/txA==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr9499337pfi.201.1583610975578;
        Sat, 07 Mar 2020 11:56:15 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id x14sm31850747pfr.23.2020.03.07.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 11:56:14 -0800 (PST)
Date:   Sat, 7 Mar 2020 11:56:13 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v8 2/8] include: fpga: adi-axi-common.h: add version
 helper macros
Message-ID: <20200307195613.GA38707@epycbox.lan>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
 <20200306110100.22092-3-alexandru.ardelean@analog.com>
 <20200307142604.7d597667@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307142604.7d597667@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 07, 2020 at 02:26:04PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Mar 2020 13:00:54 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > The format for all ADI AXI IP cores is the same.
> > i.e. 'major.minor.patch'.
> > 
> > This patch adds the helper macros to be re-used in ADI AXI drivers.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Moritz Fischer <mdf@kernel.org>

> 
> Again, trivial but needs a Moritz ack as it's his subsystem.

I had originally asked to not put it under include/linux/fpga, but alas,
now it's here :)

It never made much sense imho to drop it under linux/fpga just because
it's a hardware implemented in an FPGA....

Cheers,
Moritz
