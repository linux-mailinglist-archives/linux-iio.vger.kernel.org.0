Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202641BDD03
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD2NDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 09:03:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:25882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2NDT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Apr 2020 09:03:19 -0400
IronPort-SDR: sDOLxxoUz4dUWSf+D5DHDEYsBvPqMOAv0sYyLX/hSyKdw+IPBB3DkHeKmZFFvxBlGw9p9rEs+S
 73GRNy8OjMTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 06:03:18 -0700
IronPort-SDR: jd8PV5TJXkyfqaoGQy6o+rgxDdDEOwr2l1Lfs7V6gdeAhmGEl3n3infeGaxG+a/J13Q+VGuLOp
 6fR16xyrt0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="367798156"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Apr 2020 06:03:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 29 Apr 2020 16:03:15 +0300
Date:   Wed, 29 Apr 2020 16:03:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
Subject: Re: ucsi and DRD controller interaction
Message-ID: <20200429130315.GD2738754@kuha.fi.intel.com>
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
 <20200422142808.GE618654@kuha.fi.intel.com>
 <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
 <20200427120032.GA2351955@kuha.fi.intel.com>
 <b139b18c-0452-d717-856e-14b9dd03910a@amd.com>
 <20200429124321.GC2738754@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429124321.GC2738754@kuha.fi.intel.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi again,

> > Thanks for the details so this will enable the role switch  for drd controller. Now for UCSI driver to call the role make functions it needs the reference of the same switch reference,
> > 
> > so for that do i have to use device_get_named_child_node(dev,"CON0"), in UCSI Driver?
> 
> No. If you use the ucsi driver, and if your connector child nodes are
> in correct order, then ucsi_find_fwnode() takes care of assigning the
> node for you.
> 
> But you do need to use the USB role class API to get a handle to the
> switch (dwc3) in the typec driver.
> 
> UCSI is really meant to be a status interface. The specification
> states that the USB Type-C connectors should function autonomously
> without any OS involvement. So by relying on the driver to configure
> the muxes, you are actually corrupting that part of the specification.

I had to recheck that. I seem to be wrong about this. It does not
clearly state that the ports need to function autonomously. Also, in
this case the USB role switch isn't a mux.

Sorry about that.

> I would still strongly recommend that you use TI's own host interface.

-- 
heikki
