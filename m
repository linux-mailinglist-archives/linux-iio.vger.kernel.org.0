Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56513F33
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfEELhv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 07:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEELhv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 07:37:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D214204EC;
        Sun,  5 May 2019 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557056270;
        bh=DMn53wlsjx1Bo7lcjI92SD/gY9KTzY+WKobgCXyRZxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcrGk5guRVXMzfd2y850B6fr2Sl+xas8qHZiwQiyH5/SXpdJ3A9B4Ha3WfSj1JuAi
         TXTNEeLUkEvCeBQjb8Yo0L+/GjSq56pI3IOUEvb+U3Jn7fTcr70qpBmXaA0+rr6lBt
         vozGH5wkBSLmU6rk/4yWG29WM7ufDzo51vrRMNPY=
Date:   Sun, 5 May 2019 12:37:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, robh+dt@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        yingjoe.chen@mediatek.com, sean.wang@mediatek.com,
        erin.lo@mediatek.com, eddie.huang@mediatek.com,
        matthias.bgg@gmail.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: mt8183: add binding document
Message-ID: <20190505123731.4fda09b8@archlinux>
In-Reply-To: <20190501200125.GA29927@bogus>
References: <20190424011112.14283-1-zhiyong.tao@mediatek.com>
        <20190424011112.14283-2-zhiyong.tao@mediatek.com>
        <20190501200125.GA29927@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 May 2019 15:01:25 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, 24 Apr 2019 09:11:11 +0800, Zhiyong Tao wrote:
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing to
be ignored by the autobuilders. I'll assume the dts patch will go
via the normal soc trees.

Jonathan
