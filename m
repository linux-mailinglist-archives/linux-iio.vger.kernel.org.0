Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2372E0816
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 10:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLVJY4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 04:24:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:56926 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgLVJY4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Dec 2020 04:24:56 -0500
IronPort-SDR: kH5i1PUbxzDfTz9+tWLby1wN5qDfnK0FRMQ9Btuy841FsO2r41whz/X3wkmmbI9FwyHtHYZmnx
 epMWItf8PnIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="173273938"
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="173273938"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 01:23:09 -0800
IronPort-SDR: JMAsj9jWUD+gm6jC1vHK9PSdc0vZZ5HHoFlTSWEaJ2Bw56XUQVi33qh58ebt6X18C5P9sr4XjT
 A9S6EmqrHEPQ==
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="492127221"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 01:23:06 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 257FC205FC; Tue, 22 Dec 2020 11:23:04 +0200 (EET)
Date:   Tue, 22 Dec 2020 11:23:04 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary *-supply schemas properties
Message-ID: <20201222092304.GQ26370@paasikivi.fi.intel.com>
References: <20201221234659.824881-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221234659.824881-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

On Mon, Dec 21, 2020 at 04:46:59PM -0700, Rob Herring wrote:
> *-supply properties are always a single phandle, so binding schemas
> don't need a type $ref nor 'maxItems'.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

On media bits:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
