Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8603C4F49
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhGLHYB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbhGLHUI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 03:20:08 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C10C025397;
        Mon, 12 Jul 2021 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Ku+fho4Qa2ctqbzzklG68fzz9r2UqJK370+yapiLZc=; b=ag7kV+FXM4JBQH7e2//dT1ivFv
        A59SAxXTXopPlbcEbf+RoxCFo0UquO5n03eZLpE4Gh+7KE/cDJfcUy5RtV3h/E1+WhRnqKkogLEBO
        C61h1r1gvS0HVVVxIX3kSR8Be0J7H0+bx+WlSiyuKEq9WFAMZOHYYBKBFILR0vs5T8TI=;
Received: from p200300ccff0a76001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:7600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m2q6E-0005aH-RK; Mon, 12 Jul 2021 09:11:30 +0200
Date:   Mon, 12 Jul 2021 09:11:30 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        sre@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 2/2] power: supply: rn5t618: Add voltage_now property
Message-ID: <20210712091130.2096cf23@aktux>
In-Reply-To: <20210711112039.43c4af7b@jic23-huawei>
References: <20210705113637.28908-1-andreas@kemnade.info>
 <20210705113637.28908-3-andreas@kemnade.info>
 <20210711112039.43c4af7b@jic23-huawei>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Jul 2021 11:20:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon,  5 Jul 2021 13:36:37 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Read voltage_now via IIO and provide the property.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Reported-by: kernel test robot <lkp@intel.com>  
> Huh?  Seems unlikely it pointed out that this patch was necessary in general.
> If highlighting a particular fix in an earlier version, then state what it was
> in the commit message. Note for fixes that get rolled into patches, it's
> often just mentioned in the change log and we skip the tag because it can
> cause confusion.
> 
The robot found a problem in v1 (missing depends on IIO). It is fixed
now. The message from the bot tells to add a tag. It seems not to make
sense. But probably the bot is also running on public branches (which
will not be rebase) and uses the same message where it actually makes
sense.

I will send a v3 with that tag removed and the other comment addressed.

Regards,
Andreas
