Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3707107E59
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWM1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWM1V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:27:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE09B20714;
        Sat, 23 Nov 2019 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512041;
        bh=SsWubT6FKhUcPX8TZbsw73+cTSuxlkDbC4LL2Z9UGEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=neZaNnrM+o3iVUbzo0IBv07m+7Wphi5zxeqjfwgTjV0A0dsZhH6+1ZNf04YWxCM1/
         fnTxEM4XQ/x9RSCrSfszgMLpkFEm/e2V68JzuhHlfo9pbmQpmUxo8ZuYJq9P6Cs3Lw
         H0v2n9qD27awkBL/euL1F+OhvsC1I6MPZUlr3rws=
Date:   Sat, 23 Nov 2019 12:27:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: ad7292: fix constraint over
 channel quantity
Message-ID: <20191123122716.2e97a60d@archlinux>
In-Reply-To: <CAL_Jsq+uf3Jf87YSCuFzZMJeyqbg1==sFL6ScBVW7i_WSC61kA@mail.gmail.com>
References: <20191116205110.vvqkmujecc6u5fvi@smtp.gmail.com>
        <CAL_Jsq+uf3Jf87YSCuFzZMJeyqbg1==sFL6ScBVW7i_WSC61kA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Nov 2019 10:06:23 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Nov 16, 2019 at 2:51 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Change items property of AD7292 channels to correctly constrain their
> > quantity.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
