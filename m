Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA0157F08
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJPl5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 10:41:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58152 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgBJPl5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Feb 2020 10:41:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AE512FB03;
        Mon, 10 Feb 2020 16:41:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LdKacaLRsUai; Mon, 10 Feb 2020 16:41:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2CF1540AA3; Mon, 10 Feb 2020 16:41:54 +0100 (CET)
Date:   Mon, 10 Feb 2020 16:41:54 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Exposing device properties for priximity sensors
Message-ID: <20200210154153.GA26903@bogon.m.sigxcpu.org>
References: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
 <20200208141713.469fb174@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208141713.469fb174@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
I've been extending iio-sensor-proxy to handle iio based proximity
sensors:

    https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/merge_requests/298

The API to applications shall not export the raw value but rather tell
if an object is near by:

   https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/merge_requests/298/diffs#67dff3849420abc19453e1998b8904bbaee6f13c_67_79

So in the simplest case we'd have to set a level above which an object
is considered close:

My intitial intent was to expose that via DT but looking around in iio
drivers i couldn't see any driver doing that (i missed
iio_read_mount_matrix) and noticed that the mount matrix is given via
systemd/udev's hwdb:

    https://github.com/systemd/systemd/pull/14845

Since matching on hwdb is done via modalias we wouldn't be able to have
different values on different boards without DMI/smbios:

   https://github.com/systemd/systemd/pull/14845/files#diff-37fdc5406b715a9996bdcd3d8e439e16R539

The matching rule is explained here:

     https://github.com/systemd/systemd/blob/master/hwdb.d/60-sensor.hwdb#L12

So would specifying this via DT and then exporting via sysfs be an
acceptable solution? That is inventing something like
iio_read_close_level. The value would not be used by the driver itself
but only exposed to userspace.
Cheers,
 -- Guido

