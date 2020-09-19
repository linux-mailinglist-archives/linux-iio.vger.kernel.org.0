Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D79270E31
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISNoU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNoU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:44:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7182E2100A;
        Sat, 19 Sep 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600523060;
        bh=WbjqBn+o+PTCb9YUOn3bXrj7ki0qbcP1HeJHd9jntbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MCfCfDbVuSB+1AWUZFlzDZetFMGeAt0fXHXxNySRbd3I7CkHk+K0sI1b/KQVrGvIq
         9Ubd7LpKmId07c4z/iLSruvyQTsUC2GhEQNvHuyfJY22GCFWI2vRgV6yplmzN0TJHp
         zm1eO+KzMSL4vNjXQlXD/UixXnG/1hJ9jPla8io0=
Date:   Sat, 19 Sep 2020 14:44:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/20] dt-bindings:iio:adc:st,stmpe-adc yaml
 conversion
Message-ID: <20200919144416.2fb7bef3@archlinux>
In-Reply-To: <20200915190200.GA2314807@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-4-jic23@kernel.org>
        <20200915190200.GA2314807@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:02:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:29 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Conversion from freeform text to yaml.
> > One oddity in this binding is that, for historical reasons it requires
> > the node name to be stmpe_adc.  I've put that in the decription field
> > but I'm not sure if there is a better way to specify this?
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Stefan Agner <stefan@agner.ch>
> > ---
> >  .../bindings/iio/adc/st,stmpe-adc.yaml        | 45 +++++++++++++++++++
> >  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ---------
> >  2 files changed, 45 insertions(+), 21 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied,  Thanks,

Jonathan
