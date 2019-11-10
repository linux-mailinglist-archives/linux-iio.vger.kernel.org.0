Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6FF69FE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKJQC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 11:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJQC2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 11:02:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938962077C;
        Sun, 10 Nov 2019 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573401747;
        bh=JqeOssl5Ny8hwQaIRrCNuz6C8AgQF4ZvTQzOjm/9tFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQzWBB14eLP7OGv0DAHe+TmBNLxDELyY0bUyr5r9WyMHAS0nx52xbCDGlZwuHsoxB
         EgCfSjKiEmZ8KWGmxG+PP4XsYanJzMoh1Ad+pbEs/RB+NU4T35Bq0f8OG6ySA/1Atu
         BiaU4BeuhYXYQGVdc5kFixD32lFYRPFCZXfDmaqM=
Date:   Sun, 10 Nov 2019 16:02:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Migrate MCP3911 documentation
 to yaml
Message-ID: <20191110160221.333b8701@archlinux>
In-Reply-To: <20191108074020.GB3844@gmail.com>
References: <20191108072530.3499-1-marcus.folkesson@gmail.com>
        <20191108074020.GB3844@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Nov 2019 08:40:56 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Fri, Nov 08, 2019 at 08:25:30AM +0100, Marcus Folkesson wrote:
> > Rewrite bindings to use json-schema vocabulary.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> Forgot Robs tag from v2
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

You also forgot a change log.  I'll assume this is preferred to the
v2 I applied earlier so I've dropped that and applied this one.

Jonathan

> 

