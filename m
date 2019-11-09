Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C13F5F1D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKIMgz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKIMgz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:36:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41233207FF;
        Sat,  9 Nov 2019 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573303015;
        bh=94rB6uATtbEgExwYm/yBTizcjTGeAPvuJQYjQ5LwJB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kjWuatU2Y3QYgPQx1zMJ59fS4cQBznORLZ7LCWzd4tHW7DNWUmlqiS0eFvqAxZGwZ
         fZrmVfYc8sAauNj5DJU4bHbQ9kQRUX9VQLU37N24r2w5FPoGkfH0rcf6b2NyX8cELm
         86ZXvexof6vOJh3GeBCqHQUJ5h3p78OK8wMnI+7A=
Date:   Sat, 9 Nov 2019 12:36:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add max clock rate
 property
Message-ID: <20191109123649.0f77474e@archlinux>
In-Reply-To: <20191106032917.GA25856@bogus>
References: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
        <1572279108-25916-2-git-send-email-fabrice.gasnier@st.com>
        <20191106032917.GA25856@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Nov 2019 21:29:17 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 28 Oct 2019 17:11:47 +0100, Fabrice Gasnier wrote:
> > Add optional dt property to tune maximum desired analog clock rate.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.  Whether I get a pull request
out for this cycle or this hits early in next is dependent on whether
Linus hints at an rc8 and gives an extra week.

Thanks,

Jonathan

