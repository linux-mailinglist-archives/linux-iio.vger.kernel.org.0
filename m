Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F667ED7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfGNLg3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 07:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfGNLg2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 07:36:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA8E2064A;
        Sun, 14 Jul 2019 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563104188;
        bh=W4U+Fsz7R3sfNoE3Q3aO+4TTc5f+VydY3EMLwP3cwHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SyHwIGcOCHEoQRvBwCtCTi73AZrRZ9D46yECHXIDagfatAZzLys7t7elA/ShxXhqs
         PYtbohXeqCT/1SKw+vH33Sv5jULg6PVw7iBiFp6vJ5xB0JTGVJXvtIgP5awyrn30Xl
         KNgq1pnB7H6wvC+c0abro/aJqYE76NlLqRfB/HNQ=
Date:   Sun, 14 Jul 2019 12:36:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: pms7003: convert
 bindings to yaml
Message-ID: <20190714123623.680c3827@archlinux>
In-Reply-To: <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
References: <20190710192155.11489-1-tduszyns@gmail.com>
        <20190710192155.11489-2-tduszyns@gmail.com>
        <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Jul 2019 14:12:26 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Jul 10, 2019 at 1:22 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > Convert existing device tree bindings to yaml.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  .../iio/chemical/plantower,pms7003.txt        | 26 ----------
> >  .../iio/chemical/plantower,pms7003.yaml       | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 26 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


