Return-Path: <linux-iio+bounces-17037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803CA67BE0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5A9189D2F2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60C212B34;
	Tue, 18 Mar 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orV+1m7w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59D4C79
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322341; cv=none; b=Kcm3Jl9d1AXHk7B/1z4sUGfQls50x5hmA/Q81tuQSlo85Ipq2in+E6LFZvR520AUTjvrQPoveHhK1iI4EWbeE5qMch/TBADd0WRXVZTtBRTm6aEH3sIYymjbwhEqY/RfxGc8V8mSeEVqcIh4mouukAakRwarRsu6c7w+z7ycsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322341; c=relaxed/simple;
	bh=/UZlQRgDJ40Vwbv48N+gBWhPNEF6XQwhWZkzEHY4PQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7FDDOMsgCbHcolN4rh1jtkYXyDSR4yr7YbbvlEvhpkuEveAv8Gxi2qnkqWPZHi6c24Mk1x4+Q4VkssaaCkknr2/huRx6xuP51sTB3p+/IKFi3FuDZdQk7Qzm5g/4Ebg4PEd7r0L4WMjNEt17cUsC4lfkKywG0xVy8CXqGHNNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orV+1m7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50AC9C4CEDD
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322341;
	bh=/UZlQRgDJ40Vwbv48N+gBWhPNEF6XQwhWZkzEHY4PQ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=orV+1m7wWUw5PdyDJc1sYIVKrAPhxOnNDfTwRVv6qgoIoIyv9c3L9cp8SrPogDu/+
	 gUiAkqwkwS2NWToMdcRAGjJe73Xm6pm+rJbM/Bd+rYRVTsaM9IVa3CLXLjHLf0gTnE
	 ucGwJza3zenh/+CbaADB/5cTEkfq1j/n3l0t4Fr7di8OnxEM83QzdaTiJDxscOCyrU
	 tk9Oqbs9nUZC6pLQQ0+fwWd2lEOKqqtR5iNv/N1qJSLKzEsENRNAtlxPhA0PbqBol7
	 Yt2O9DYeZpzBfXuqn8hjMpZhaBHHmXFc5rqdu/AXUhl/XJEDsxewz8jsD0IDk6nB6G
	 kgDWvu+Rs2cDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 419ECC3279F; Tue, 18 Mar 2025 18:25:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 18:25:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219890-217253-Kdw67hWDhX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #11 from Fred (wysiwyg81@rbox.co) ---
Created attachment 307852
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307852&action=3Dedit
logs from iio_generic_buffer

This are the logs from :

echo on | sudo tee
/sys/bus/platform/devices/HID-SENSOR-200041.6.auto/power/control

sudo ./iio_generic_buffer -N 0 -a -c 1000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

