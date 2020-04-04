Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CED19E56F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDDOQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDOQe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:16:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91A0206C3;
        Sat,  4 Apr 2020 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009794;
        bh=jYh8ojEfBjWhcionJm7bLgdtcMaLtTKw3IPbO1FXFv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RqPr8qa75t3W6KS03U5hHpDlF4XP2X6lqAjJCAFU6vIZPD1LrQ++H9BcAGdjGxrPr
         DUkJVaLa15/fM9zucspy/AP1uQhw2WVq2t6qELZKy1M8Dge7qhAnEHiD845ewQntin
         poTmrHUrLuGuNa17buSgeJ0Jyk7IBoylskKvq704=
Date:   Sat, 4 Apr 2020 15:16:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, olivier.moysan@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: stm32-dac: convert bindings
 to json-schema
Message-ID: <20200404151628.52576e43@archlinux>
In-Reply-To: <20200330232040.GA16570@bogus>
References: <1584639983-31098-1-git-send-email-fabrice.gasnier@st.com>
        <20200330232040.GA16570@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 17:20:40 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 19 Mar 2020 18:46:23 +0100, Fabrice Gasnier wrote:
> > Convert the STM32 DAC binding to DT schema format using json-schema
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v2:
> > - Fix id relative path/filename as detected by Rob's bot
> > ---
> >  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  63 ------------
> >  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  | 110 +++++++++++++++++++++
> >  2 files changed, 110 insertions(+), 63 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan


