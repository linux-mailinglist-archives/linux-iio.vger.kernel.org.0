Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6592A18A88D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 23:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCRWqp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 18:46:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22364 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCRWqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 18:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584571604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q2OzC4cgVQGEsU7x7ynrOzwWtdjStHhZd/duWGehPc=;
        b=hjbEgUpux4J+caHP0n8jrItjnzjNg2uaAKlxvTmtjs/uDzafLNoto7L+J5TwojvJXu9koO
        4AJM1R7Xz7DXic2BiqrzjAO9V4tK1GKYtSCkgbxGHFGm5kxlVvL0a7F1cIuU1PD6XFfE9n
        G3mZNpd0AQ/kpElq+ZgkN3f1Tbkzii4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-UULRDAnbP52jA24Sc2hXxA-1; Wed, 18 Mar 2020 18:46:42 -0400
X-MC-Unique: UULRDAnbP52jA24Sc2hXxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE1F0800D53;
        Wed, 18 Mar 2020 22:46:40 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9A6DBBBC0;
        Wed, 18 Mar 2020 22:46:36 +0000 (UTC)
Date:   Wed, 18 Mar 2020 23:46:31 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: iio: adc: ad7192:
 Re-indent enum labels
Message-ID: <20200318234631.5a5ec8b0@elisabeth>
In-Reply-To: <7aa18b6226a644e12302a055cbc17b41a2ccb02a.1584557481.git.mh12gx2825@gmail.com>
References: <cover.1584557481.git.mh12gx2825@gmail.com>
        <7aa18b6226a644e12302a055cbc17b41a2ccb02a.1584557481.git.mh12gx2825@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 00:38:24 +0530
Deepak R Varma <mh12gx2825@gmail.com> wrote:

> Re-indent enum labels as per coding style guidelines. Problem
> detected by checkpatch script.
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

This, and all the patches in this series, also need a 'v2' in the
subject.

-- 
Stefano

