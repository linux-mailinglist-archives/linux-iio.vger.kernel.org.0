Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF7684D0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfGOIEB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:04:01 -0400
Received: from mail133-22.atl131.mandrillapp.com ([198.2.133.22]:45299 "EHLO
        mail133-22.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfGOIEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 04:04:01 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 04:04:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=VSAtOYjdYu8frJkKtKcesmwi099NUTNw9EPSls9KEqE=;
 b=XD405b8941VRcXAU+gGOQ/4UbnMEwZhJ+qayUEbAXwWqqkpwCOYggUlYw5OcHFeCmQNR74gEvgH7
   EvgHA4nM6U1r4q5/sGHWcOmkeJCUkUUhz7G6olSUdQPAuDoATuElG2FLowL8nHa+eTi4PKX7oi1M
   hPYJTjJjbDACrUa0oRs=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-22.atl131.mandrillapp.com id h5gpn01sar8e for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 07:33:59 +0000 (envelope-from <bounce-md_31050260.5d2c2c67.v1-0ad35a854a554d16bef4c6801ec3ac1f@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1563176039; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=VSAtOYjdYu8frJkKtKcesmwi099NUTNw9EPSls9KEqE=; 
 b=PdtJb98I5GQcqlmK+4hf2AkthiUWCVFutWAfJcAxImOTugFUxSTzl5Roq4E0iV5tw6MWkU
 2aoSUmAa2SdB3avczozuyyE8T+UYtv5n1bDCRLlLXMJBGe7YKQppZnivopsmz2T8w9FvhN7F
 x6f+qE1w6s7LnaxdpdbtVCqkfiFjU=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PULL] stream_open bits for Linux 5.3
Received: from [87.98.221.171] by mandrillapp.com id 0ad35a854a554d16bef4c6801ec3ac1f; Mon, 15 Jul 2019 07:33:59 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, Jan Blunck <jblunck@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <cocci@systeme.lip6.fr>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pr-tracker-bot@kernel.org>
Message-Id: <20190715073353.GA3208@deco.navytux.spb.ru>
References: <20190714141317.GA20277@deco.navytux.spb.ru> <156315060268.32091.6748401501797941411.pr-tracker-bot@kernel.org>
In-Reply-To: <156315060268.32091.6748401501797941411.pr-tracker-bot@kernel.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.0ad35a854a554d16bef4c6801ec3ac1f
X-Mandrill-User: md_31050260
Date:   Mon, 15 Jul 2019 07:33:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 15, 2019 at 12:30:02AM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Sun, 14 Jul 2019 14:13:45 +0000:
> 
> > https://lab.nexedi.com/kirr/linux.git stream_open-5.3
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/fcd98147ac71f35b69e2f50b5fddc5524dd2dfa8

Thanks.
