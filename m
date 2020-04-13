Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033A41A6B06
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbgDMRKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgDMRKf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 13:10:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E6F2063A;
        Mon, 13 Apr 2020 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586797835;
        bh=2bIeFIgC0v1N+hwC8FN56cNLCsH4bCC7m9SXvdjQn4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ehCMcWbgM6jWykOjJMii2EIfClmkS8734b62kPvBsFVFovS/gHsozotRiU3N4WgBX
         NqwjR6g3IAcmWriTJEc46JTir9Wh7bCqauTs1vSAyhXxsf+i82+qJ2zMvske3Lig+Q
         7cBnN5RgfPao9x4bj/9qJlibGwBtmQN8iP+pHbYc=
Date:   Mon, 13 Apr 2020 18:10:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: chemical: atlas-sensor: add DO support
Message-ID: <20200413181031.68e101da@archlinux>
In-Reply-To: <20200210001058.7515-1-matt.ranostay@konsulko.com>
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Hi Matt,

Found this still in my queue and to be honest I'm lost and
can't easily figure out what the status is (I'm too lazy to
read all the past threads).

So what do you think the status of this patch set is?

Thanks,

Jonathan

On Sun,  9 Feb 2020 16:10:55 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Changes from v1:
> * combined dt binding docs
> * added making interrupt line is optional patchset
> * broke out dt changes from DO-SM module patchset
> 
> Changes from v2:
> * switch docs to YAML format
> 
> Changes from v3:
> * fix up issues reported with dt-schema
> 
> Changes from v4:
> * fix logic issue in optional interrupt patchset
> 
> Changes from v5:
> * Update license on yaml conversion to GPLv2.0+ and BSD clause
> 
> Matt Ranostay (3):
>   iio: chemical: atlas-sensor: allow probe without interrupt line
>   iio: chemical: atlas-sensor: add DO-SM module support
>   dt-bindings: iio: chemical: consolidate atlas-sensor docs
> 
>  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
>  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
>  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
>  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++
>  drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
>  5 files changed, 125 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> 

