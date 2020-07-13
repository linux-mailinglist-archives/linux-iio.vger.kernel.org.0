Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051A21DA40
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGMPir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 11:38:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44038 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMPir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 11:38:47 -0400
Received: by mail-io1-f68.google.com with SMTP id i4so13907434iov.11;
        Mon, 13 Jul 2020 08:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pMcvMtCRWhdkza41G5iTrQjI/XTs22mJcQM1Op8aHQ=;
        b=Iv4Hrr/dUAJKf118WQ5qzc+OC2dtjXcyXishm6opFfBSvDfrBtSUFMegGglcaiT790
         ZeEpshIIQe9IocRW8sLJD8EDVwK7HeySDHBvm9559HDTxfszBu6NG6XTKZzcw1ZQAYvZ
         f21fDqvM+7ha9cWL9ONc9CHBjnUz5RXHv3w7SiMB2EYUOKhdA2Goy3Auu5SUpIC3PRIu
         Tf5tRsiyijKogYPoN+JyVmHHfJM+vPEIICzoQArzndik8ZCc/YlcA8TxCFcPxjZPPE35
         AY9P3B8pGN0Q/UykkCXL8N3PxHMfBZ2np9c/UKQFUvsvMdqFmx6eSbNtS3OMIIyRO3Fw
         scrg==
X-Gm-Message-State: AOAM533KzQ3zZlc+t0ccXWBoJBk/F/2fbGjj8yK/smWPORRw4YH1smRd
        YwxEvFHSnqZZ9z89lzr65Q==
X-Google-Smtp-Source: ABdhPJyr5leUy9cs5NZ0gs+zeLxzAY1E/Eas3j0IhKpTcy+VYH3b8iJIsqmfcJrPkNajPPxeXCsyjg==
X-Received: by 2002:a02:a909:: with SMTP id n9mr695975jam.70.1594654726254;
        Mon, 13 Jul 2020 08:38:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y6sm8426457ila.74.2020.07.13.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:38:45 -0700 (PDT)
Received: (nullmailer pid 253739 invoked by uid 1000);
        Mon, 13 Jul 2020 15:38:44 -0000
Date:   Mon, 13 Jul 2020 09:38:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Eugene Zaikonnikov <ez@norphonic.com>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v9 2/2] dt-bindings: iio: humidity: Add TI HDC20x0 support
Message-ID: <20200713153844.GA250984@bogus>
References: <86d053d1re.fsf@norphonic.com>
 <86blknd0id.fsf@norphonic.com>
 <20200712115920.4041260c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712115920.4041260c@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 12, 2020 at 11:59:20AM +0100, Jonathan Cameron wrote:
> On Fri, 10 Jul 2020 14:20:58 +0200
> Eugene Zaikonnikov <ez@norphonic.com> wrote:
> 
> > Add device tree bindings for HDC2010/HDC2080 family of humidity and
> > temperature sensors.
> > 
> 
> As Andy mentioned for patch 1 please avoid attachments.
> 
> > Changes from v8:
> > - document the use of reg
> > - change the license terms to GPL-2.0-only
> 
> The change log should be after the --- (which isn't here because
> of the attachments issue).  This is so we don't track a bunch of change
> logs in the eventual git log.  They tend not to be of much interest once
> a patch has merged.  If there is stuff in there of interest, it should usually
> be added to the patch description itself (e.g. some design decision or similar).
> 
> The license terms seem to be dual with BSD, which is good, but
> not what the change log says!
> 
> I've pasted in the actual patch content below, so others can easily
> review this version.

Other than those issues,

Reviewed-by: Rob Herring <robh@kernel.org>
