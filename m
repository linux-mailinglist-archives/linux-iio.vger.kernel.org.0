Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9484C92646
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHSOPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 10:15:36 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42186 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfHSOPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2019 10:15:36 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2CA7E25AF0E;
        Tue, 20 Aug 2019 00:15:34 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0FAD79406ED; Mon, 19 Aug 2019 16:15:32 +0200 (CEST)
Date:   Mon, 19 Aug 2019 16:15:31 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: isl29501: Rename bindings
 documentation file
Message-ID: <20190819141531.daj5gfpcb2sco5fq@verge.net.au>
References: <20190819140105.18800-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819140105.18800-1-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 19, 2019 at 04:01:05PM +0200, Simon Horman wrote:
> Rename the bindings documentation file for Renesas ISL29501 Time-of-flight
> sensor from isl29501.txt to renesas,isl29501.txt.
> 
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3-rc1
> ---
>  .../bindings/iio/light/{isl29501.txt => renesas,isl29501.txt}         | 0
>  Makefile                                                              | 4 ++--

Sorry, I seem to have messed this up a bit: the Makefile portion should not
be there.  I'll shake things out and repost.
