Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DD3EE8DB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhHQIv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 04:51:27 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:36436 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234833AbhHQIvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 04:51:24 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6ACC0181CC1CF;
        Tue, 17 Aug 2021 08:50:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 2B67627DD32;
        Tue, 17 Aug 2021 08:50:49 +0000 (UTC)
Message-ID: <5d8c6cb42c2ee156027699ab1e5fa5b476188678.camel@perches.com>
Subject: Re: [PATCH] staging:iio:ade7854 surround complex defines in
 parentheses
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel watson <ozzloy@challenge-bot.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 01:50:46 -0700
In-Reply-To: <YRtTRpioOFBYxcxJ@kroah.com>
References: <20210815023115.13016-1-ozzloy@challenge-bot.com>
         <YRizb/FGfYpGbpJy@kroah.com> <20210817043038.GA9492@challenge-bot.com>
         <YRtTRpioOFBYxcxJ@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2B67627DD32
X-Stat-Signature: aj6zgh7o3amw79kd8ndqzy3na5mtho6u
X-Spam-Status: No, score=-1.26
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18HA2mP+Mt4fwdV5dckwI6oocs8qqrpHME=
X-HE-Tag: 1629190249-913308
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-08-17 at 08:12 +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 16, 2021 at 09:30:38PM -0700, daniel watson wrote:
> > 
> > If this is a false positive from checkpatch, I can submit it as an
> > example to the checkpatch maintainers.  Do you think I should?
> 
> checkpatch is a perl script that does pattern matching, it is really
> hard for it to determine for things like this specific example, that it
> is not needed.
> 
> Try finding other valid checkpatch cleanups if you wish to contribute in
> this way, there are loads of others under drivers/staging/ that should
> be easy to find.

These macros, and several other '#define ADE7854_<FOO> <value>' instances,
are apparently unused and could possibly be removed instead.


