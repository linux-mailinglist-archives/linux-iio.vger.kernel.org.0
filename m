Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF192AABE6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgKHP3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHP3L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:29:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6CD206E0;
        Sun,  8 Nov 2020 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604849350;
        bh=LO5JP7loOG/rhx2URhXeys5m6yKMzppXxoeIZLjmeCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MshF4R62iRSb1m2m4kUYF6m6lZrGaFgFZ+wTCetJEzUDFwcg+cxj9FFndFmqYENw9
         Pod/zyZfnq4qNGMzdPNoFos30XypQYvJEZKPh7+5CYSAA++6P3XZak3A2JQCF2tI7f
         yZ1f7BLsY6s0bvMKjLLjmbqOkJV47IbtShsYgl/U=
Date:   Sun, 8 Nov 2020 15:29:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] dt-bindings:iio:adc:adc.txt: Add documentation
 for channel label attribute
Message-ID: <20201108152912.6712c267@archlinux>
In-Reply-To: <20201105173718.GA1526144@bogus>
References: <20201102142000.68916-1-cristian.pop@analog.com>
        <20201102142000.68916-5-cristian.pop@analog.com>
        <20201105173718.GA1526144@bogus>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Nov 2020 11:37:18 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 02 Nov 2020 16:20:00 +0200, Cristian Pop wrote:
> > Optional attribute for better identification of the channels.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> > Changes in v7:
> >  - Add this extra commit
> >  Documentation/devicetree/bindings/iio/adc/adc.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Series applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if we missed anything.

Thanks,

Jonathan


