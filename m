Return-Path: <linux-iio+bounces-17040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B561A67C29
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A794882C55
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A22212D65;
	Tue, 18 Mar 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icVh4jqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3D2135DE
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322983; cv=none; b=f3YfMWqe5QexqBfe0IpzNz9afFDYg1XkQ7/4kINiZKi3PoSyd0DpwEQYyYb88Dpconfc1BNnFpXsvBIZ/HXXCQ0NiA1sz6KMcGlUNpDPCzuyhwJ5RfUVcwse9juTISaNx6HoD9gkVM6px1EcwI2Ilu3c5dyqN68PEL7qixzC5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322983; c=relaxed/simple;
	bh=lEemDKMgnIgB03ES7/wb9+VnutqdVyJuIpM3HovEi3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yt9IHz2lznRhn75EosalVh/MK3LOq4Z0jgO2D3EYPkaMFWz6RnGSgx3sIxBTA5m7TvBvLIrOgff/7jpUQSrJmTcAr2mJ4BxP4/wFO+CP4iQf7eJ+IXFYKoPkEImzX799vVgfGpBQSQCBieW20YT2+nhbXFHbP2QWBj0wYvVlSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icVh4jqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94EA4C4CEDD
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322983;
	bh=lEemDKMgnIgB03ES7/wb9+VnutqdVyJuIpM3HovEi3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=icVh4jqF9Umb8LZAjcMZLem96c0HOdOdblJODzSMkeDw15q4VUZi209NFcwB30kzE
	 RciJIr1UeqDcZ2Ua66+qiKuhVnzVn6esIUUdXf+gmMZ+tQMauqkPyMXMeGvH4WUWyz
	 S/idYuqkv/1uLPIanTqDcC5+vK8qGteR06aGdddNQ16D1VhjJkiNZ+2Q1uaA4QHeTN
	 KXonwu/pOkNRun9gvexwQE+aIxgxUqgyHwLU0aHtGbvolOz/43xdQlATQc93yAjSCz
	 6nPVrJoajIHvo+Qkh5acBaovbzDkvt6RGSKH0l/+PYt7DIlgFHmh3TsxnvW3wk0S9C
	 lfsE2HGThwnnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 89FCAC3279F; Tue, 18 Mar 2025 18:36:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 18:36:23 +0000
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
Message-ID: <bug-219890-217253-z8tU2DViYf@https.bugzilla.kernel.org/>
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

--- Comment #14 from Fred (wysiwyg81@rbox.co) ---
Created attachment 307853
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307853&action=3Dedit
logs from iio_generic_buffer

added a log with control back to auto (50 samples)

echo auto | sudo tee
/sys/bus/platform/devices/HID-SENSOR-200041.6.auto/power/control

sudo ./iio_generic_buffer -N 0 -a -c 50

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

